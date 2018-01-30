using Godot;
using System;
using System.Timers;

public class Snake : Node2D
{
    // 640x360
    // casillas de 40x40 (mcd 640,360)
    private System.Timers.Timer timer;
    private static readonly Random rnd = new Random();
    private Apple apple;
    private SnakeBody body;
    public override void _Ready()
    {
        body = GetNode("SnakeBody") as SnakeBody;
        body.Position = new Vector2(0,0);
        timer = new System.Timers.Timer(10000);
        timer.Elapsed += NewApple;
        timer.AutoReset = true;
        timer.Start();
        apple = GetNode("Apple") as Apple;
        apple.Position = new Vector2(rnd.Next(15)*40,rnd.Next(8)*40);
    }

    public void NewApple(object src ,ElapsedEventArgs e)
    {
        if(apple != null){
            RemoveChild(apple);
        }
        apple = new Apple();
        apple.Position = new Vector2(rnd.Next(0,15)*40,rnd.Next(0,8)*40);
        AddChild(apple);
    }

    public override void _Process(float delta)
    {
        if(apple != null){
            if(body.TryEat(apple)){
                RemoveChild(apple);
                apple = null;
            }
        }
        
    }
}
