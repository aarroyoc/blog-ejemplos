mod sqlite;

use sqlite::{sqlite3_open, sqlite3_exec, sqlite3_close, SQLITE_OK};
use std::ffi::CString;
use std::ptr::{null_mut,null};

fn main(){
    let mut db = null_mut();
    let database_name = CString::new("test.db").unwrap().into_raw();
    let sql = CString::new("
    CREATE TABLE contacts (name TEXT, tel TEXT);
    INSERT INTO contacts VALUES ('Adrian','555-555-555');").unwrap().into_raw(); 
    let mut error_msg = null_mut();
    unsafe{
        sqlite3_open(database_name,&mut db);
        let rc = sqlite3_exec(db,sql,None,null_mut(),&mut error_msg);
        if rc != SQLITE_OK as i32 {
            let error = CString::from_raw(error_msg);
            println!("ERROR: {}",error.into_string().unwrap());
        }
        sqlite3_close(db);
    }
}
