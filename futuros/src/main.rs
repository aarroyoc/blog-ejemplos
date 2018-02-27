extern crate tokio;
extern crate tokio_io;
extern crate futures;
extern crate futures_cpupool;

use futures::prelude::*;
use std::time;
use std::thread;
use futures_cpupool::CpuPool;
use tokio_io::AsyncRead;
use futures::Stream;
use tokio_io::codec::*;
use std::rc::Rc;
use std::cell::RefCell;

fn suma(a: i32, b: i32) -> SumFuture {
    SumFuture{
        a: a,
        b: b
    }
}

struct SumFuture{
    a: i32,
    b: i32
}

impl Future for SumFuture {
    type Item = i32;
    type Error = String;

    fn poll(&mut self) -> Result<Async<i32>,String> {
        thread::sleep(time::Duration::from_secs(1));
        Ok(Async::Ready(self.a+self.b))
    }
}

struct Cancellable{
    rx: std::sync::mpsc::Receiver<()>,
}

impl Future for Cancellable {
    type Item = ();
    type Error = std::sync::mpsc::RecvError;

    fn poll(&mut self) -> Result<Async<Self::Item>,Self::Error> {
        match self.rx.try_recv() {
            Ok(_) => Ok(Async::Ready(())),
            Err(_) => Ok(Async::NotReady)
        }
    }
}

fn main() {
    let c = suma(4,5)
    .and_then(|v|{
        suma(v,40)
    }).and_then(|v|{
        suma(v,40)
    });
    let d = suma(15,14);
    
    let pool: CpuPool = CpuPool::new_num_cpus();
    let c = pool.spawn(c);
    let d = pool.spawn(d);
    let (c,d) = c.join(d).wait().unwrap();
    println!("SUMAS: {},{}",c,d);
    // -- SERVER
    use std::net::*;
    let socket = SocketAddr::new(IpAddr::V4(Ipv4Addr::new(127, 0, 0, 1)), 8080);
    let listener = tokio::net::TcpListener::bind(&socket).unwrap();
    let server = listener.incoming().for_each(|socket|{
        let (writer,reader) = socket.framed(LinesCodec::new()).split();
        let (tx,rx) = std::sync::mpsc::channel();
        let cancel = Cancellable {
            rx: rx,
        };
        let action = reader
        .map(move |line|{
            println!("ECHO: {}",line);
            if line == "bye"{
                println!("BYE");
                tx.send(()).unwrap();
            }
            line
        })
        .forward(writer)
        .select2(cancel)
        .map(|_|{

        })
        .map_err(|err|{
            println!("error");
        });
        tokio::executor::current_thread::spawn(action);
        
        Ok(())
    }).map_err(|err|{
        println!("error = {:?}",err);
    });
    tokio::executor::current_thread::run(|_|{
        tokio::executor::current_thread::spawn(server);
    });
}
