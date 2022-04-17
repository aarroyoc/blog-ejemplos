:- module aoc2021day1.
:- interface.

:- import_module io.

:- pred main(io::di, io::uo) is det.

:- implementation.

:- import_module int.
:- import_module list.
:- import_module string.

:- pred load_data(string::in, list(string)::out, io::di, io::uo) is det.

load_data(Filename, ReadData, !IO) :-
    io.read_named_file_as_lines(Filename, OpenResult, !IO),
    (if OpenResult = ok(Data) then
        ReadData = Data
     else
        ReadData = []
    ).

:- pred solve(list(int)::in, int::out) is det.
solve([], 0).
solve([_], 0).
solve([X,Y|Xs], N) :-
    solve([Y|Xs], N0),
    (if X < Y then
        N = N0 + 1
    else
        N = N0
    ).

:- pred slide_window(list(int)::in, list(int)::out) is det.
slide_window([], []).
slide_window([_], []).
slide_window([_,_], []).
slide_window([X,Y,Z|Xs], Ys) :-
    slide_window([Y,Z|Xs], Ys0),
    N = X + Y + Z,
    Ys = [N|Ys0].

:- pred solve2(list(int)::in, int::out) is det.
solve2(Data, N) :-
    slide_window(Data, Slides),
    solve(Slides, N).

main(!IO) :-
    load_data("input", ReadData, !IO),
    (if list.map(string.to_int, ReadData, Data) then
        solve(Data, N),
	io.format("Solution 1: %d\n", [i(N)], !IO),
	solve2(Data, M),
	io.format("Solution 2: %d\n", [i(M)], !IO)
    else
        io.write_string("Invalid file\n", !IO)
    ).
