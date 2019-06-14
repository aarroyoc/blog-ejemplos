from kanren import run, membero, var

x = var()
sol = run(1,x,
    membero(x,[1,2,3]),
    membero(x,[2,3,4])
    )
print(sol)
