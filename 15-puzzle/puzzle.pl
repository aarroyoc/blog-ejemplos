:- use_module(library(lists)).
:- use_module(library(format)).
:- use_module(library(pio)).

easy_state(table(void,1,2,3,5,6,7,4,9,10,11,8,13,14,15,12)).
medium_state(table(13,9,5,4,15,6,1,8,void,10,2,11,14,3,7,12)).
rosetta_state(table(15,14,1,6,9,11,4,12,void,10,7,3,13,8,5,2)).
wikipedia_state(table(15,2,1,12,8,5,6,11,4,9,10,7,3,14,13,void)).
end_state(table(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,void)).

%% display_state(State) :-
%%     phrase_to_stream(display_state_(State), user_output).

%% display_int(void) -->
%%     !,
%%     format_("\x2502\  ", []).
%% display_int(X) -->
%%     format_("\x2502\~|~`0t~d~2+", [X]).

%% display_state_(table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16)) -->
%%     format_("\x250c\\x2500\\x2500\\x252c\\x2500\\x2500\\x252c\\x2500\\x2500\\x252c\\x2500\\x2500\\x2510\\n", []),
%%     display_int(X1),
%%     display_int(X2),
%%     display_int(X3),
%%     display_int(X4),
%%     format_("\x2502\\n\x251c\\x2500\\x2500\\x253c\\x2500\\x2500\\x253c\\x2500\\x2500\\x253c\\x2500\\x2500\\x2524\\n", []),
%%     display_int(X5),
%%     display_int(X6),
%%     display_int(X7),
%%     display_int(X8),
%%     format_("\x2502\\n\x251c\\x2500\\x2500\\x253c\\x2500\\x2500\\x253c\\x2500\\x2500\\x253c\\x2500\\x2500\\x2524\\n", []),
%%     display_int(X9),
%%     display_int(X10),
%%     display_int(X11),
%%     display_int(X12),
%%     format_("\x2502\\n\x251c\\x2500\\x2500\\x253c\\x2500\\x2500\\x253c\\x2500\\x2500\\x253c\\x2500\\x2500\\x2524\\n", []),
%%     display_int(X13),
%%     display_int(X14),
%%     display_int(X15),
%%     display_int(X16),
%%     format_("\x2502\\n", []),
%%     format_("\x2514\\x2500\\x2500\\x2534\\x2500\\x2500\\x2534\\x2500\\x2500\\x2534\\x2500\\x2500\\x2518\\n", []).

solve([_-state(S0,H,_)|_], _, H) :-
    end_state(S0).
solve([_-state(S0, H0, N0)|States], Visited, H) :-
    findall(F-state(S, [M|H0], N), (
		move(M, S0, S),
		\+ member(S, States),
		\+ member(S, Visited),
		h_value(S, HVal),
		N is N0+1,
		F is HVal + N
	    ), NewStates),
    append(States, NewStates, AllStates),!,
    keysort(AllStates, OrderedAllStates),
    solve(OrderedAllStates, [S0|Visited], H).

h_value(S, H) :-
    S =.. [_|Ls],
    maplist(distance(Ls), Ls, Ds),
    sum_list(Ds, H).

distance(_, void, 0) :- !.
distance(Ls, E, D) :-
    nth0(N, Ls, E),
    X0 is N // 4,
    Y0 is N mod 4,
    X1 is (E-1) // 4,
    Y1 is (E-1) mod 4,
    D is abs(X1-X0)+abs(Y1-Y0).
    

move(left, table(X1,void,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(void,X1,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,void,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,void,X2,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,void,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,X2,void,X3,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,void,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,void,X5,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,void,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,void,X6,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,X7,void,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,X6,void,X7,X9,X10,X11,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,void,X11,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,void,X9,X11,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,void,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,void,X10,X12,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,void,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,void,X11,X13,X14,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,void,X15,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,void,X13,X15,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,void,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,void,X14,X16)).
move(left, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,void), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,void,X15)).
    
move(right, S0, S) :-
    move(left, S, S0).

move(up, table(X1,X2,X3,X4,void,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(void,X2,X3,X4,X1,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,void,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,void,X3,X4,X5,X2,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,void,X8,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,X2,void,X4,X5,X6,X3,X8,X9,X10,X11,X12,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,void,X9,X10,X11,X12,X13,X14,X15,X16), table(X1,X2,X3,void,X5,X6,X7,X4,X9,X10,X11,X12,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,void,X10,X11,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,void,X6,X7,X8,X5,X10,X11,X12,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,void,X11,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,void,X7,X8,X9,X6,X11,X12,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,void,X12,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,X6,void,X8,X9,X10,X7,X12,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,void,X13,X14,X15,X16), table(X1,X2,X3,X4,X5,X6,X7,void,X9,X10,X11,X8,X13,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,void,X14,X15,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,void,X10,X11,X12,X9,X14,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,void,X15,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,void,X11,X12,X13,X10,X15,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,void,X16), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,void,X12,X13,X14,X11,X16)).
move(up, table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,void), table(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,void,X13,X14,X15,X12)).

move(down, S0, S) :-
    move(up, S, S0).
