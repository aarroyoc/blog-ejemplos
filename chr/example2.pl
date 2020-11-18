:- use_module(library(chr)).

:- chr_constraint fib/2, upto/1.

fib(A, AV), fib(B, BV), upto(N) ==> B is A+1, B < N | X is AV+BV, K is B+1, fib(K, X).