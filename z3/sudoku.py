from z3 import *

sudoku = [4,0,0,0,6,0,9,1,0,
         2,0,0,0,0,7,0,5,0,
         0,9,0,8,0,0,0,2,0,
         0,0,1,6,0,9,0,0,2,
         0,8,0,0,0,0,0,6,3,
         0,7,0,0,4,0,0,0,0,
         7,0,3,0,0,8,0,9,0,
         0,0,0,0,3,0,4,0,5,
         0,4,0,9,0,0,6,0,0]

s = Solver()
# generate vars
sudoku_z3 = []
for i,cell in enumerate(sudoku):
    if cell == 0:
        sudoku_z3.append(Int(f"sudoku_{i}"))
    else:
        sudoku_z3.append(IntVal(cell))

# limits
for var in sudoku_z3:
    s.add(var >= 1)
    s.add(var <= 9)

# rows
for i in range(9):
    row = [sudoku_z3[j] for j in range(9*i, 9*(i+1))]
    s.add(Distinct(*row))

# columns
for i in range(9):
    column = [sudoku_z3[j] for j in range(i, 81, 9)]
    s.add(Distinct(*column))

# square
for i in range(9):
    o = i // 3
    p = i % 3
    square = [
        sudoku_z3[o*27+p*3],
        sudoku_z3[o*27+p*3+1],
        sudoku_z3[o*27+p*3+2],
        sudoku_z3[o*27+p*3+9],
        sudoku_z3[o*27+p*3+10],
        sudoku_z3[o*27+p*3+11],
        sudoku_z3[o*27+p*3+18],
        sudoku_z3[o*27+p*3+19],
        sudoku_z3[o*27+p*3+20]
    ]
    s.add(Distinct(square))

print(s.check())

for i, cell in enumerate(sudoku):
    if cell == 0:
        print(f"{s.model()[sudoku_z3[i]]}", end=" ")
    else:
        print(f"{cell}", end=" ")
    if i % 9 == 8:
        print()
    

