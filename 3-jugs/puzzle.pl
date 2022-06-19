:- use_module(library(lists)).
:- use_module(library(clpz)).
:- use_module(library(format)).

solve(Vs) :-
    states(States),
    end_states(States, EndStates),
    arcs(States, Arcs),
    length(Vs, _),
    automaton(Vs, [source(0-0-8)|EndStates], Arcs),
    label(Vs).


states(States) :-
    [A,B,C] ins 0..8,
    A+B+C #= 8,
    findall(A-B-C, label([A,B,C]), States).

end_states(States, EndStates) :-
    findall(sink(S), (
		member(S, States),
		S = A-B-C,
		(A = 4; B = 4; C = 4)
	    ), EndStates).

arcs(States, Arcs) :-
    findall(arc(S0, Action, S1),(
		member(S0, States),
		member(S1, States),
		S0 \= S1,
		arc(S0, Action, S1)
	    ), Arcs).



% Arcs
% ab
arc(A-B-C, 1, X-Y-Z) :-
    Dif #= min(A, 5-B),
    X #= A - Dif,
    Y #= B + Dif,
    Z = C.
% ac
arc(A-B-C, 2, X-Y-Z) :-
    Dif #= min(A, 8-C),
    X #= A - Dif,
    Y = B,
    Z #= C + Dif.
% bc
arc(A-B-C, 3, X-Y-Z) :-
    Dif #= min(B, 8-C),
    X = A,
    Y #= B - Dif,
    Z #= C + Dif.
% ba
arc(A-B-C, 4, X-Y-Z) :-
    Dif #= min(B, 3-A),
    X #= A + Dif,
    Y #= B - Dif,
    Z = C.
% ca
arc(A-B-C, 5, X-Y-Z) :-
    Dif #= min(C, 3-A),
    X #= A + Dif,
    Y = B,
    Z #= C - Dif.
% cb 
arc(A-B-C, 6, X-Y-Z) :-
    Dif #= min(C, 5-B),
    X = A,
    Y #= B + Dif,
    Z #= C - Dif.

print(Xs) :- print(Xs, 0-0-8).
print([], _).
print([X|Xs], S) :-
    arc(S, X, S1),
    S = A-B-C,
    S1 = D-E-F,
    format("Going from (~d,~d,~d) to (~d, ~d, ~d)\n", [A,B,C,D,E,F]),
    print(Xs, S1).
