extern crate gtk;
extern crate rand;

use gtk::prelude::*;
use rand::distributions::{IndependentSample, Range};
use std::rc::Rc;
use std::cell::Cell;

fn pick(a: i32, b: i32) -> i32 {
    let between = Range::new(a, b);
    let mut rng = rand::thread_rng();
    between.ind_sample(&mut rng)
}

fn main() {
    if gtk::init().is_err() {
        println!("Failed to initialize GTK.");
        return;
    }

    let window = gtk::Window::new(gtk::WindowType::Toplevel);

    window.set_title("Adrianistán - GTK - Rust");
    window.set_border_width(10);
    window.set_position(gtk::WindowPosition::Center);
    window.set_default_size(350, 70);

    window.connect_delete_event(|_, _| {
        gtk::main_quit();
        Inhibit(false)
    });

    let vbox = gtk::Box::new(gtk::Orientation::Vertical,10);

    let button = gtk::Button::new_with_label("Tirar el dado");

    let label = gtk::Label::new("No has tirado el dado todavía");

    let r = Rc::new(Cell::new(0));

    let random = r.clone();
    let drawingarea = gtk::DrawingArea::new();
    drawingarea.set_size_request(300,300);
    drawingarea.connect_draw(move |widget,cr|{
        let width: f64 = widget.get_allocated_width() as f64;
        let height: f64 = widget.get_allocated_height() as f64;
        cr.rectangle(0.0,0.0,width,height);
        cr.set_source_rgb(1.0,1.0,1.0);
        cr.fill();

        cr.set_source_rgb(0.,0.,0.);
        let random = random.get();
        if random == 1 || random == 3 || random == 5{
            cr.arc(width/2.0,height/2.,height/10.,0.0,2.0*std::f64::consts::PI);
        }
        cr.fill();
        if random == 2 || random == 3 || random == 4 || random == 5 || random == 6 {
            cr.arc(width/4.,height/4.,height/10.,0.0,2.0*std::f64::consts::PI);
            cr.arc(3.*width/4.,3.*height/4.,height/10.,0.0,2.0*std::f64::consts::PI);
        }
        cr.fill();

        if random == 4 || random == 5 || random == 6 {
            cr.arc(3.*width/4.,height/4.,height/10.,0.0,2.0*std::f64::consts::PI);
            cr.arc(width/4.,3.*height/4.,height/10.,0.0,2.0*std::f64::consts::PI);
        }
        cr.fill();
        
        if random == 6 {
            cr.arc(width/2.,height/4.,height/10.,0.0,2.0*std::f64::consts::PI);
            cr.arc(width/2.,3.*height/4.,height/10.,0.0,2.0*std::f64::consts::PI);
        }
        cr.fill();
        Inhibit(false)
    });

    let l = label.clone();
    let dado = r.clone();
    let da = drawingarea.clone();
    button.connect_clicked(move |_| {
        dado.set(pick(1,7));
        let text: String = format!("Dado: {}",dado.get());
        l.set_text(text.as_str());
        da.queue_draw();
    });
    
    vbox.add(&button);
    vbox.add(&label);
    vbox.add(&drawingarea);
    window.add(&vbox);

    window.show_all();
    gtk::main();
}
