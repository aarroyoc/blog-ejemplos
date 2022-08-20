:- use_module(library(between)).
:- use_module(library(dcgs)).
:- use_module(library(format)).
:- use_module(library(lists)).
:- use_module(library(reif)).
% plan - checks the validation of a scuba plan and fills holes
%
% ?- plan([s(TimeStamp, Depth, _Gas), ...
%
% ?- plan([s(0, 0, 200), s(2, 10, _), s(22, 10, _), s(30, 0, _)]).

plan(Plan) :-
    Plan = [X|Xs],
    X = s(0, 0, _),
    plan(X, Xs),
    deco_time(Plan),
    phrase(safe_stop, Plan).

deco_time(Plan) :-
    foldl(plan_max_depth, Plan, 0, MaxDepth),
    append(_, [s(T,_,_)], Plan),
    padi_depth(MaxDepth, _PG, T).

safe_stop -->
    ... ,
    [s(T0, D0, _),s(T1, D1, _), _],
    {
	T1 - T0 >= 3,
	between(4, 6, D0),
	between(4, 6, D1)
    }.

plan(S, []) :-
    S = s(_, D, _),
    D = 0.
plan(S0, [S|Ss]) :-
    S0 = s(T0, D0, G0),
    S = s(T, D, G),
    between(0, 100, T),
    between(0, 100, T0),
    between(0, 30, D),
    between(0, 30, D0),
    between(50, 200, G0),
    T > T0,
    DifTime is T - T0,
    DifDepth is D0 - D,
    % Max SAFE speed to ascend is 9/min SSI or 18/min PADI
    (
	DifDepth > 0 ->
	DifDepth / DifTime =< 9
    ;   true
    ),
    pressure_dif(DifTime, D0, D, GasConsumption),
    G is G0 - round(GasConsumption),
    between(50, 200, G),
    plan(S, Ss).

% Calculates the pressure difference between two times, probably at different depth
pressure_dif(DifTime, D0, D, DifGas) :-
    breathing_rate(BR),
    bottle_size(BL),
    DifVolume is BR*DifTime*(((D0+D) / 20)+1), % breathing rate * time * air pressure
    DifGas is DifVolume / BL. % Air volume = Bottle volume * bottle pressure

% Breathing Rate (20 L/m) to (70 L/m)
breathing_rate(20).
% Bottle Sizes (10, 12, 15, 18)
bottle_size(12).

plan_max_depth(State, MaxDepth0, MaxDepth) :-
    State = s(_, D, _),
    MaxDepth is max(MaxDepth0, D).

test :-
    % ok, normal
    plan([s(0, 0, 200), s(2, 11, _), s(22, 11, _), s(25, 5, _), s(28, 5, _), s(30, 0, G0)]),
    G0 = 104,
    % no safety stop
    \+ plan([s(0, 0, 200), s(2, 10, _), s(22, 10, _), s(30, 0, _)]),
    % fail (doesn't start at 0)
    \+ plan([s(0, 10, 200), s(2, 10, _), s(22, 10, _), s(30, 0, _)]),
    % fail (no air)
    \+ plan([s(0, 0, 200), s(2, 10, _), s(50, 10, _), s(70, 0, _)]),
    % fail (max SAFE speed)
    \+ plan([s(0, 0, 200), s(2, 10, _), s(7, 30, _), s(8, 0, _)]).


% padi(MaxDepth, PressureGroup, Time)
padi(10, a, 10).
padi(10, b, 20).
padi(10, c, 26).
padi(10, d, 30).
padi(10, e, 34).
padi(10, f, 37).
padi(10, g, 41).
padi(10, h, 45).
padi(10, i, 50).
padi(10, j, 54).
padi(10, k, 59).
padi(10, l, 64).
padi(10, m, 70).
padi(10, n, 75).
padi(10, o, 82).
padi(10, p, 88).
padi(10, q, 95).
padi(10, r, 104).
padi(10, s, 112).
padi(10, t, 122).
padi(10, u, 133).
padi(10, v, 145).
padi(10, w, 160).
padi(10, x, 178).
padi(10, y, 199).
padi(10, z, 219).
padi(12, a, 9).
padi(12, b, 17).
padi(12, c, 23).
padi(12, d, 26).
padi(12, e, 29).
padi(12, f, 32).
padi(12, g, 35).
padi(12, h, 38).
padi(12, i, 42).
padi(12, j, 45).
padi(12, k, 49).
padi(12, l, 53).
padi(12, m, 57).
padi(12, n, 62).
padi(12, o, 66).
padi(12, p, 71).
padi(12, q, 76).
padi(12, r, 82).
padi(12, s, 88).
padi(12, t, 94).
padi(12, u, 101).
padi(12, v, 108).
padi(12, w, 116).
padi(12, x, 125).
padi(12, y, 134).
padi(12, z, 147).
padi(14, a, 8).
padi(14, b, 15).
padi(14, c, 19).
padi(14, d, 22).
padi(14, e, 24).
padi(14, f, 27).
padi(14, g, 29).
padi(14, h, 32).
padi(14, i, 35).
padi(14, j, 37).
padi(14, k, 40).
padi(14, l, 43).
padi(14, m, 47).
padi(14, n, 50).
padi(14, o, 53).
padi(14, p, 57).
padi(14, q, 61).
padi(14, r, 64).
padi(14, s, 68).
padi(14, t, 73).
padi(14, u, 77).
padi(14, v, 82).
padi(14, w, 87).
padi(14, x, 92).
padi(14, y, 98).
padi(16, a, 7).
padi(16, b, 13).
padi(16, c, 17).
padi(16, d, 19).
padi(16, e, 21).
padi(16, f, 23).
padi(16, g, 25).
padi(16, h, 27).
padi(16, i, 29).
padi(16, j, 32).
padi(16, k, 34).
padi(16, l, 37).
padi(16, m, 39).
padi(16, n, 42).
padi(16, o, 45).
padi(16, p, 48).
padi(16, q, 50).
padi(16, r, 53).
padi(16, s, 56).
padi(16, t, 60).
padi(16, u, 63).
padi(16, v, 67).
padi(16, w, 70).
padi(16, x, 72).
padi(18, a, 6).
padi(18, b, 11).
padi(18, c, 15).
padi(18, d, 16).
padi(18, e, 18).
padi(18, f, 20).
padi(18, g, 22).
padi(18, h, 24).
padi(18, i, 26).
padi(18, j, 28).
padi(18, k, 30).
padi(18, l, 32).
padi(18, m, 34).
padi(18, n, 36).
padi(18, o, 39).
padi(18, p, 41).
padi(18, q, 43).
padi(18, r, 46).
padi(18, s, 48).
padi(18, t, 51).
padi(18, u, 53).
padi(18, v, 55).
padi(18, w, 56).
padi(20, a, 6).
padi(20, b, 10).
padi(20, c, 13).
padi(20, d, 15).
padi(20, e, 16).
padi(20, f, 18).
padi(20, g, 20).
padi(20, h, 21).
padi(20, i, 23).
padi(20, j, 25).
padi(20, k, 26).
padi(20, l, 28).
padi(20, m, 30).
padi(20, n, 32).
padi(20, o, 34).
padi(20, p, 36).
padi(20, q, 38).
padi(20, r, 40).
padi(20, s, 42).
padi(20, t, 44).
padi(20, u, 45).
padi(22, a, 5).
padi(22, b, 9).
padi(22, c, 12).
padi(22, d, 13).
padi(22, e, 15).
padi(22, f, 16).
padi(22, g, 18).
padi(22, h, 19).
padi(22, i, 21).
padi(22, j, 22).
padi(22, k, 24).
padi(22, l, 25).
padi(22, m, 27).
padi(22, n, 29).
padi(22, o, 30).
padi(22, p, 32).
padi(22, q, 34).
padi(22, r, 36).
padi(22, s, 37).
padi(25, a, 4).
padi(25, b, 8).
padi(25, c, 10).
padi(25, d, 11).
padi(25, e, 13).
padi(25, f, 14).
padi(25, g, 15).
padi(25, h, 17).
padi(25, i, 18).
padi(25, j, 19).
padi(25, k, 21).
padi(25, l, 22).
padi(25, m, 23).
padi(25, n, 25).
padi(25, o, 26).
padi(25, p, 28).
padi(25, q, 29).
padi(30, a, 3).
padi(30, b, 6).
padi(30, c, 8).
padi(30, d, 9).
padi(30, e, 10).
padi(30, f, 11).
padi(30, g, 12).
padi(30, h, 13).
padi(30, i, 14).
padi(30, j, 15).
padi(30, k, 16).
padi(30, l, 17).
padi(30, m, 18).
padi(30, n, 19).
padi(30, o, 20).
padi_depth(D, PG, T) :-
    T < 219,
    (
	padi(D, _, _) ->
	(
	    padi(D, PG, T) ->
	    true
	;   (
	    T1 is T + 1,
	    padi_depth(D, PG, T1)
	)
	)
    ;
	(
	    D1 is D+1,
	    padi_depth(D1, PG, T)
	)
    ).
