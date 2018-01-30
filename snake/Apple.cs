using Godot;
using System;

public class Apple : Sprite
{

    public override void _Ready()
    {

        
    }

    public override void _Draw()
    {
        this.DrawCircle(new Vector2(20,20),15,new Color(0,1,0));
        Console.WriteLine($"Position: {Position}");
    }
}
