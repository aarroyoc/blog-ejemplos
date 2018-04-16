
suma([],0).
suma([H|C],N) :-
	suma(C,R),
	N is H+R.

suma2(L,N) :-
	[H|C] = L,
	(sumar(C,N1),!,N is H+N1);(N is 0).

borrar(Elemento,[Elemento|C],C).
borrar(Elemento,[H|C],[H|R]) :- borrar(Elemento,C,R).

insertar(Elemento,[],[Elemento]).
insertar(Elemento,[H|C],[Elemento|R]) :- R = [H|C].
insertar(Elemento,[H|C],[H|R]) :- insertar(Elemento,C,R).
