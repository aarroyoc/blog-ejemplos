from kanren import run, var, fact, Relation

x = var() 
human = Relation()

fact(human,"Socrates")

def mortal(x):
    return human(x)

sol = run(1,x,mortal(x))
print(sol)
