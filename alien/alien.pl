:- use_module(library(dcgs)).
:- use_module(library(clpz)).

hex_number(N) -->
    hex(A),
    hex(B),
    {
        N #= B + A*16
    }.

hex(0) --> "0".
hex(1) --> "1".
hex(2) --> "2".
hex(3) --> "3".
hex(4) --> "4".
hex(5) --> "5".
hex(6) --> "6".
hex(7) --> "7".
hex(8) --> "8".
hex(9) --> "9".
hex(10) --> "A".
hex(11) --> "B".
hex(12) --> "C".
hex(13) --> "D".
hex(14) --> "E".
hex(15) --> "F".

dec_number(N) -->
    dec(A),
    dec(B),
    {
        N #= B + A*10
    }.

dec(0) --> "0".
dec(1) --> "1".
dec(2) --> "2".
dec(3) --> "3".
dec(4) --> "4".
dec(5) --> "5".
dec(6) --> "6".
dec(7) --> "7".
dec(8) --> "8".
dec(9) --> "9".

inv([A, B], [B, A]).

puzzle(Hex) :-
    phrase(hex_number(N), Hex),
    inv(Hex, Dec),
    phrase(dec_number(N), Dec).
