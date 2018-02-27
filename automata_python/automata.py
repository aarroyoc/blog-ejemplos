import numpy as np
from PIL import Image

WIDTH = 5001
HEIGHT = 5001

class Automata(object):

    rules = list()

    def __init__(self,idx=0):
        self.idx = idx
        self.state = False
        self.statePrev = False

class World(object):
    def __init__(self,rule=50):
        self.rule = rule
        self.im = Image.new("L",(WIDTH,HEIGHT))
        self.data = np.zeros(WIDTH*HEIGHT,dtype=np.uint8)
        b = bin(rule)[2:].zfill(8)
        Automata.rules = [True if c == "1" else False for c in b]
        print(Automata.rules)
        self.list = list()
        self.step = 0
    
    def add(self):
        automata = Automata(len(self.list))
        self.list.append(automata)

    def update(self):
        for automata in self.list:

            automata.statePrev = automata.state
            p = self.list[automata.idx - 1].statePrev if automata.idx > 0 else False
            n = self.list[automata.idx + 1].state if automata.idx < len(self.list)-1 else False
            s = automata.state

            if p and s and n:
                automata.state = automata.rules[0]
            elif p and s and not n:
                automata.state = automata.rules[1]
            elif p and not s and n:
                automata.state = automata.rules[2]
            elif p and not s and not n:
                automata.state = automata.rules[3]
            elif not p and s and n:
                automata.state = automata.rules[4]
            elif not p and s and not n:
                automata.state = automata.rules[5]
            elif not p and not s and n:
                automata.state = automata.rules[6]
            elif not p and not s and not n:
                automata.state = automata.rules[7]
            

    def draw_row(self):
        if self.step == 0:
            middle = (len(self.list) // 2)
            self.list[middle].state = True
        for i,automata in enumerate(self.list):
            if automata.state:
                self.data[self.step*HEIGHT+i] = 255
        self.step += 1
    def save(self):
        self.im.putdata(self.data)
        self.im.save("RULE-%d.png" % self.rule)
    def __str__(self):
        s = str()
        for l in self.list:
            s += "T" if l.state else "F"
        return s

def world_run(rule):
    world = World(rule)
    for _ in range(WIDTH):
        world.add()

    for _ in range(HEIGHT):
        world.draw_row()
        world.update()
    world.save()

def main():
    rule = input("Rule: ")
    try:
        rule = int(rule)
        if 255 >= rule >= 0:
            world_run(rule)
            print("Check for the generated RULE-%d.png file" % rule)
        else:
            raise ValueError
    except ValueError:
        print("Please, insert a number between 0 and 255")
        main()

if __name__ == "__main__":
    main()
