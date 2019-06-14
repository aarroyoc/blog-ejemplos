from kanren import run, eq, conde, var, Relation, facts

x = var()
y = var()
sol = run(1,[x,y],eq(x,42),eq(y,5))
print(sol[0])

parent = Relation()
facts(parent,("Homer","Bart"),
        ("Homer","Lisa"),
        ("Abe","Homer"))

sol = run(2,x,parent("Homer",x))
print(sol[0])
print(sol[1])

def grandparent(x,z):
    y = var()
    return conde((parent(x,y), parent(y,z)))

sol = run(1,x,grandparent(x,"Bart"))
print(sol[0])
