-module(exercises).

-export([existe/2, maxlis/1]).

existe(Lis, E) ->
    Xs = lists:map(fun(X) -> X == E end, Lis),
    lists:foldr(fun(X, Acc) -> X or Acc end, false, Xs).

maxn(X, Acc) ->
    if X > Acc ->
	X;
    true ->
        Acc
    end.

maxlis(Lis) ->
    [X|Xs] = Lis,
    lists:foldr(fun maxn/2, X, Xs).


