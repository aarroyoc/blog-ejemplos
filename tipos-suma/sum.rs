struct Position {
    x: f64,
    y: f64,
}

enum Shape {
    Circle {
        position: Position,
        radius: f64,
    },
    Rect {
        position: Position,
        width: f64,
        height: f64,
    }
}

fn area(shape: &Shape) -> f64 {
    match shape {
        Shape::Circle { radius, .. } => std::f64::consts::PI * (radius.powf(2.0)),
        Shape::Rect { width, height, ..} => width * height
    }
}

fn area2(shape: &Shape) -> f64 {
    if let Shape::Circle { radius, .. } = shape {
        return std::f64::consts::PI * (radius.powf(2.0));
    }
    if let Shape::Rect { width, height, ..} = shape {
        return width * height;
    }
    unreachable!();
}

fn main(){
    let mut shapes = Vec::new();
    shapes.push(Shape::Circle {
        position: Position {
            x: 5.0,
            y: 6.0,
        },
        radius: 4.0
    });
    shapes.push(Shape::Rect {
        position: Position {
            x: 5.0,
            y: 6.0,
        },
        width: 70.0,
        height: 80.0
    });

    let shape = shapes.get(0);
    if let Some(shape) = shape {
        area(&shape);
    }
    
}