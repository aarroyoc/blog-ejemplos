gen(a, X) :-
    X = [8,3,5,9,6,4,2,1,7,
         1,4,2,8,5,7,3,9,6,
         7,6,9,2,3,1,8,4,5,
         4,5,1,6,7,8,9,2,3,
         2,7,6,3,4,9,5,8,1,
         3,9,8,5,1,2,7,6,4,
         5,2,3,1,8,6,4,7,9,
         9,1,4,7,2,5,6,3,8,
         6,8,7,4,9,3,1,5,2].

gen(b, X) :-
    X = [4,x,x,x,6,x,9,1,x,
         2,x,x,x,x,7,x,5,x,
         x,9,x,8,x,x,x,2,x,
         x,x,1,6,x,9,x,x,2,
         x,8,x,x,x,x,x,6,3,
         x,7,x,x,4,x,x,x,x,
         7,x,3,x,x,8,x,9,x,
         x,x,x,x,3,x,4,x,5,
         x,4,x,9,x,x,6,x,x].

gen(c, X) :-
    X = [x,3,5,9,6,4,2,1,x,
         1,4,2,8,5,7,3,9,6,
         7,6,9,2,3,1,8,4,5,
         4,5,1,6,7,8,9,2,3,
         2,7,6,3,4,9,5,8,1,
         3,9,8,5,1,2,7,6,4,
         5,2,3,1,8,6,4,7,9,
         9,1,4,7,2,5,6,3,8,
         x,8,7,4,9,3,1,5,x].

row(Sudoku, N, Row) :-
    N0 is N-1,
    N1 is N0*9+1, nth1(N1, Sudoku, X1),
    N2 is N0*9+2, nth1(N2, Sudoku, X2),
    N3 is N0*9+3, nth1(N3, Sudoku, X3),
    N4 is N0*9+4, nth1(N4, Sudoku, X4),
    N5 is N0*9+5, nth1(N5, Sudoku, X5),
    N6 is N0*9+6, nth1(N6, Sudoku, X6),
    N7 is N0*9+7, nth1(N7, Sudoku, X7),
    N8 is N0*9+8, nth1(N8, Sudoku, X8),
    N9 is N0*9+9, nth1(N9, Sudoku, X9),
    Row = [X1, X2, X3, X4, X5, X6, X7, X8, X9].

column(Sudoku, N, Column) :-
    N1 is 0*9+N, nth1(N1, Sudoku, X1),
    N2 is 1*9+N, nth1(N2, Sudoku, X2),
    N3 is 2*9+N, nth1(N3, Sudoku, X3),
    N4 is 3*9+N, nth1(N4, Sudoku, X4),
    N5 is 4*9+N, nth1(N5, Sudoku, X5),
    N6 is 5*9+N, nth1(N6, Sudoku, X6),
    N7 is 6*9+N, nth1(N7, Sudoku, X7),
    N8 is 7*9+N, nth1(N8, Sudoku, X8),
    N9 is 8*9+N, nth1(N9, Sudoku, X9),
    Column = [X1, X2, X3, X4, X5, X6, X7, X8, X9].

square(Sudoku, N, Square) :-
    O is (N-1) // 3,
    P is (N-1) mod 3,
    N1 is O*27+P*3+1 , nth1(N1, Sudoku, X1),
    N2 is O*27+P*3+2 , nth1(N2, Sudoku, X2),
    N3 is O*27+P*3+3 , nth1(N3, Sudoku, X3),
    N4 is O*27+P*3+10 , nth1(N4, Sudoku, X4),
    N5 is O*27+P*3+11 , nth1(N5, Sudoku, X5),
    N6 is O*27+P*3+12 , nth1(N6, Sudoku, X6),
    N7 is O*27+P*3+19 , nth1(N7, Sudoku, X7),
    N8 is O*27+P*3+20 , nth1(N8, Sudoku, X8),
    N9 is O*27+P*3+21 , nth1(N9, Sudoku, X9),
    Square = [X1, X2, X3, X4, X5, X6, X7, X8, X9].

valid(R) :-
    is_set(R).

program([H|T]) --> digit(H), program(T).
program([]) --> [].
digit(N) --> [N], { number(N) } .
digit(X) --> [x].

check(SolvedSudoku, N) :-
    between(1,9,N),
    row(SolvedSudoku, 1, R1), valid(R1),
    row(SolvedSudoku, 2, R2), valid(R2),
    row(SolvedSudoku, 3, R3), valid(R3),
    row(SolvedSudoku, 4, R4), valid(R4),
    row(SolvedSudoku, 5, R5), valid(R5),
    row(SolvedSudoku, 6, R6), valid(R6),
    row(SolvedSudoku, 7, R7), valid(R7),
    row(SolvedSudoku, 8, R8), valid(R8),
    row(SolvedSudoku, 9, R9), valid(R9),
    column(SolvedSudoku, 1, C1), valid(C1),
    column(SolvedSudoku, 2, C2), valid(C2),
    column(SolvedSudoku, 3, C3), valid(C3),
    column(SolvedSudoku, 4, C4), valid(C4),
    column(SolvedSudoku, 5, C5), valid(C5),
    column(SolvedSudoku, 6, C6), valid(C6),
    column(SolvedSudoku, 7, C7), valid(C7),
    column(SolvedSudoku, 8, C8), valid(C8),
    column(SolvedSudoku, 9, C9), valid(C9),
    square(SolvedSudoku, 1, S1), valid(S1),
    square(SolvedSudoku, 2, S2), valid(S2),
    square(SolvedSudoku, 3, S3), valid(S3),
    square(SolvedSudoku, 4, S4), valid(S4),
    square(SolvedSudoku, 5, S5), valid(S5),
    square(SolvedSudoku, 6, S6), valid(S6),
    square(SolvedSudoku, 7, S7), valid(S7),
    square(SolvedSudoku, 8, S8), valid(S8),
    square(SolvedSudoku, 9, S9), valid(S9).

sudoku(Sudoku, SolvedSudoku) :-
    phrase(program(SolvedSudoku), Sudoku),!,
    maplist(check(SolvedSudoku), SolvedSudoku).
