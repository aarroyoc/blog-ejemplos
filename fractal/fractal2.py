from turtle import *
from math import cos, pi

a = 0

def fractal(length=100,level=1,flip=False):
    # 3906 llamadas a fractal = 5^5 + 5^4 + 5^3 + 5^2 + 5^1 + 5^0
    ((r,g,b),_) = color()
    global a
    a += 1
    if a % 7 == 0 and a < 1953:
        b += 1
    if a % 7 == 0 and a > 1953:
        r += 1
        b -= 1

    r = min(r,255)
    g = max(g,0)
    b = min(b,255)
    b = max(b,0)

    color(int(r),int(g),int(b))

    if not flip:
        left(90)
    else:
        right(90)
    if level == 1:
        forward(length)
    else:
        fractal(length*length/(2*cos(45)*length/2+length),level-1,flip)
    if not flip:
        right(45)
    else:
        left(45)
    if level == 1:
        forward(length/2)
    else:
        fractal(length*length/(4*cos(45)*length/2+length),level-1,not flip)
    if not flip:
        right(45)
    else:
        left(45)
    if level == 1:
        forward(length)
    else:
        fractal(length*length/(2*cos(45)*length/2+length),level-1,flip)
    if not flip:
        right(45)
    else:
        left(45)
    if level == 1:
        forward(length/2)
    else:
        fractal(length*length/(4*cos(45)*length/2+length),level-1,not flip)
    if not flip:
        right(45)
    else:
        left(45)
    if level == 1:
        forward(length)
    else:
        fractal(length*length/(2*cos(45)*length/2+length),level-1,flip)
    if not flip:
        left(90)
    else:
        right(90)

def main():
    colormode(255)
    penup()
    pensize(2.0)
    setx(-100)
    sety(-200)
    pendown()
    color(0,255,0)
    speed(0)
    tracer(False)
    fractal(50,6)
    done()


main()
