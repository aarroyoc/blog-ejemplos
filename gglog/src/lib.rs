use std::ffi::CString;

use swipl::prelude::*;
use raylib_sys::*;

struct PrologColor{
    r: u8,
    g: u8,
    b: u8,
    a: u8
}

term_getable!{
    (PrologColor, "color", term) => {
        let r: i64 = attempt_opt(term.get_arg(1)).unwrap_or(None)?;
        let g: i64 = attempt_opt(term.get_arg(2)).unwrap_or(None)?;
        let b: i64 = attempt_opt(term.get_arg(3)).unwrap_or(None)?;
        let a: i64 = attempt_opt(term.get_arg(4)).unwrap_or(None)?;

        Some(PrologColor{
            r: r as u8,
            g: g as u8,
            b: b as u8,
            a: a as u8
        })
    }
}

predicates! {
    semidet fn init_raylib(_context, width, height, title) {
        let width = width.get::<i64>()? as i32;
        let height = height.get::<i64>()? as i32;
        let title = title.get::<String>()?;
        let title = CString::new(title).unwrap();

        unsafe {
            InitWindow(width, height, title.as_ptr());
        }
        
        Ok(())
    }

    semidet fn should_close(_context) {
        unsafe {
            if WindowShouldClose() {
                Ok(())
            } else {
                Err(PrologError::Failure)
            }
        }
    }

    semidet fn begin_drawing(_context) {
        unsafe  {
            BeginDrawing();
        }
        Ok(())
    }

    semidet fn end_drawing(_context) {
        unsafe {
            EndDrawing();
        }
        Ok(())
    }

    semidet fn clear_background(_context, color) {
        let color: PrologColor = color.get()?;
        unsafe {
            ClearBackground(Color{
                r: color.r,
                g: color.g,
                b: color.b,
                a: color.a
            });
        }
        Ok(())
    }

    semidet fn draw_text(_context, msg, x, y, font, color) {
        let msg = msg.get::<String>()?;
        let msg = CString::new(msg).unwrap();
        let x = x.get::<i64>()? as i32;
        let y = y.get::<i64>()? as i32;
        let font = font.get::<i64>()? as i32;
        let color: PrologColor = color.get()?;

        unsafe {
            DrawText(msg.as_ptr(), x, y, font, Color {
                r: color.r,
                g: color.g,
                b: color.b,
                a: color.a,
            });
        }
        Ok(())
    }
}

#[no_mangle]
pub extern "C" fn install() {
    register_init_raylib();
    register_should_close();
    register_begin_drawing();
    register_clear_background();
    register_draw_text();
    register_end_drawing();
}
