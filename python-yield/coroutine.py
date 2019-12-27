def gen():
    yield from sub()

def sub():
    yield "Hola Mundo"

def main():
    f = gen()
    print(next(f))

main()
