

type Position = {
    x: number,
    y: number,
};

interface Circle {
    type: "circle",
    position: Position,
    radius: number,
}

type Rect = {
    type: "rect",
    position: Position,
    width: number,
    height: number,
}

type Shape = Circle | Rect;

function middlePoint(a: Shape, b: Shape): Position {
    const x = (a.position.x + b.position.x) / 2;
    const y = (a.position.y + b.position.y) / 2;
    return { x, y};
}

function area(a: Shape, b: Shape): number {
    if(a.type === "circle"){
        return Math.PI*Math.pow(a.radius, 2);
    } else {
        return a.height*a.width;
    }
}

function main(){
    let shapes: Shape[] = [];
    shapes.push({
        type: "circle",
        position: {
            x: 50,
            y: 60
        },
        radius: 7
    });
    shapes.push({
        type: "rect",
        position: {
            x: 50,
            y: 60,
        },
        width: 40,
        height: 30,
    });
    const point = middlePoint(shapes[0], shapes[1]);


    // NULL
    let shape = shapes.find((t: Shape) => t.position.x === 40);
    if(shape){
        area(shape, shapes[0]);
    }

}

main();