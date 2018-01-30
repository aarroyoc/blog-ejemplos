using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public class SnakeBody : Sprite
{
    private float time = 0;
    private enum Direction{
        LEFT,
        RIGHT,
        UP,
        DOWN
    };
    private Direction direction;
    private List<Rect2> body;
    private bool eat = false;
    public override void _Ready()
    {
        // Called every time the node is added to the scene.
        // Initialization here
        direction = Direction.RIGHT;
        body = new List<Rect2>();
        body.Add(new Rect2(0,0,40,40));
        body.Add(new Rect2(40,0,40,40));
        SetZIndex(1);
    }

    public override void _Draw()
    {
        var color = new Color(1,0,0);
        foreach(var rect in body){
            this.DrawRect(new Rect2(rect.Position.x+2,rect.Position.y+2,36,36),color);
        }
    }

    public bool TryEat(Apple apple)
    {
        if(body[0].Position.x == apple.Position.x && body[0].Position.y == apple.Position.y){
            Console.WriteLine("EAT!");
            eat = true;
        }

        return eat;
    }

    public bool Crash()
    {
        return body.Skip(1).Any(t=>{
            return t.Position.x == body[0].Position.x && t.Position.y == body[0].Position.y;
        });
    }

    public override void _Process(float delta)
    {
        // Called every frame. Delta is time since last frame.
        // Update game logic here.
        time += delta;
        if(time > 0.5){
            Vector2 translation;
            switch(direction){
                case Direction.RIGHT: translation=new Vector2(40,0);break;
                case Direction.LEFT: translation=new Vector2(-40,0);break;
                case Direction.UP: translation = new Vector2(0,-40);break;
                default: translation = new Vector2(0,40);break;
            }
            if(body.Count > 0){
                var newRect = new Rect2(body[0].Position,body[0].Size);
                newRect.Position += translation;
                if(newRect.Position.x < 0){
                    newRect.Position = new Vector2(600,newRect.Position.y);
                }
                if(newRect.Position.x > 600){
                    newRect.Position = new Vector2(0,newRect.Position.y);
                }
                if(newRect.Position.y < 0){
                    newRect.Position = new Vector2(newRect.Position.x,320);
                }    
                if(newRect.Position.y > 320){
                    newRect.Position = new Vector2(newRect.Position.x,0);
                }

                
                body.Insert(0,newRect);
                if(!eat){
                    body.RemoveAt(body.Count-1);
                }
                if(Crash()){
                    Console.WriteLine("CRASH! Game Over");
                }
            }
            this.Update();
            time = 0;
            eat = false;
        }
    }

    public override void _Input(InputEvent @event)
    {
        if(@event.IsAction("move_left") && direction != Direction.RIGHT)
        {
            direction = Direction.LEFT;
            return;
        }
        if(@event.IsAction("move_right") && direction != Direction.LEFT)
        {
            direction = Direction.RIGHT;
            return;
        }
        if(@event.IsAction("move_up") && direction != Direction.DOWN)
        {
            direction = Direction.UP;
            return;
        }
        if(@event.IsAction("move_down") && direction != Direction.UP)
        {
            direction = Direction.DOWN;
            return;
        }
    }
}
