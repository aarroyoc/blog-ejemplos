:- use_module(library(clpz)).
:- use_module(library(format)).

match_points(Goals1, Goals2, Points1, Points2) :-
    Goals1 #> Goals2,
    Points1 #= 3,
    Points2 #= 0.

match_points(Goals1, Goals2, Points1, Points2) :-
    Goals1 #< Goals2,
    Points1 #= 0,
    Points2 #= 3.

match_points(Goals1, Goals2, Points1, Points2) :-
    Goals1 #= Goals2,
    Points1 #= 1,
    Points2 #= 1.

soccerdoku :-
    [A1, A2, A3, U4, U5, T6, U1, T2, R3, T4, R5, R6] ins 0..4,
    A1 + A2 + A3 #= 4,
    U4 + U5 + U1 #= 4,
    T6 + T2 + T4 #= 1,
    R3 + R5 + R6 #= 1,
    A1 + T4 + R5 #= 5,
    A2 + U4 + R6 #= 2,
    A3 + U5 + T6 #= 3,
    match_points(A1, U1, PA1, _),
    match_points(A2, T2, PA2, _),
    match_points(A3, R3, PA3, PR3),
    match_points(U5, R5, _, PR5),
    match_points(T6, R6, _, PR6),
    PA1 + PA2 + PA3 #= 7,
    PR3 + PR5 + PR6 #= 1,
    label([A1, A2, A3, U4, U5, T6, U1, T2, R3, T4, R5, R6]),
    Width = 15,
    format("Albion ~t~d~*+ - United ~t~d~*+~n", [A1, Width, U1, Width]),
    format("Albion ~t~d~*+ - Town ~t~d~*+~n", [A2, Width, T2, Width]),
    format("Albion ~t~d~*+ - Rovers ~t~d~*+~n", [A3, Width, R3, Width]),
    format("United ~t~d~*+ - Town ~t~d~*+~n", [U4, Width, T4, Width]),
    format("United ~t~d~*+ - Rovers ~t~d~*+~n", [U5, Width, R5, Width]),
    format("Town ~t~d~*+ - Rovers ~t~d~*+~n", [T6, Width, R6, Width]).

