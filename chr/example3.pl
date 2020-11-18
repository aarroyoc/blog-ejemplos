:- use_module(library(chr)).

:- chr_constraint connected/2, origin/2, edge/4, node/2, world/0.


world <=> 
    node(1, 1),
    node(1, 2),
    node(2, 1),
    node(2, 2),
    node(3, 1),
    node(3, 2),
    node(4, 1),
    node(4, 2),
    edge(1, 1, 2, 1),
    edge(2, 1, 3, 1),
    edge(3, 1, 4, 1),
    edge(2, 1, 2, 2),
    edge(4, 1, 4, 2).

origin(X, Y) <=> connected(X, Y).
connected(X1, Y1), edge(X1, Y1, X2, Y2) \ node(X2, Y2) <=> connected(X2, Y2). 