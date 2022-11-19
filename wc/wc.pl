:- use_module(library(format)).
:- use_module(library(lists)).
:- use_module(library(pio)).

:- initialization(run).

run :-
    phrase_from_file(state(was_space, 1, 0, 0, Lines, Words, Chars), "quijote.txt"),
    format("~d ~d ~d~n", [Lines, Words, Chars]),
    halt.

state(_, space, was_space).
state(_, newline, new_line).
state(was_space, word, new_word).
state(new_line, word, new_word).
state(new_word, word, was_word).
state(was_word, word, was_word).

type(X, space) :- member(X, " \t").
type('\n', newline).
type(X, word) :- \+ member(X, " \t\n").

state(was_space, Lines0, Words0, Chars0, Lines, Words, Chars) -->
    [X],
    {
	type(X, Type),
	state(was_space, Type, NextState),
	Chars1 is Chars0 + 1
    },
    state(NextState, Lines0, Words0, Chars1, Lines, Words, Chars).

state(new_line, Lines0, Words0, Chars0, Lines, Words, Chars) -->
    [X],
    {
	type(X, Type),
	state(new_line, Type, NextState),
	Lines1 is Lines0 + 1,
	Chars1 is Chars0 + 1
    },
    state(NextState, Lines1, Words0, Chars1, Lines, Words, Chars).
	
state(new_word, Lines0, Words0, Chars0, Lines, Words, Chars) -->
    [X],
    {
	type(X, Type),
	state(new_word, Type, NextState),
	Words1 is Words0 + 1,
	Chars1 is Chars0 + 1
    },
    state(NextState, Lines0, Words1, Chars1, Lines, Words, Chars).

state(was_word, Lines0, Words0, Chars0, Lines, Words, Chars) -->
    [X],
    {
	type(X, Type),
	state(was_word, Type, NextState),
	Chars1 is Chars0 + 1
    },
    state(NextState, Lines0, Words0, Chars1, Lines, Words, Chars).

state(_, L, W, C, L, W, C) --> [].
