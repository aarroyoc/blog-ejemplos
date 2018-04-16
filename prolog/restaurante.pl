%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Programa restaurante  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%	

% menu

entrada(paella).
entrada(gazpacho).
entrada(consome).

carne(filete_de_cerdo).
carne(pollo_asado).

pescado(trucha).
pescado(bacalao).

postre(flan).
postre(nueces_con_miel).
postre(naranja).

% Valor calorico de una raci�n

calorias(paella, 200).
calorias(gazpacho, 150).
calorias(consome, 300).
calorias(filete_de_cerdo, 400).
calorias(pollo_asado, 280).
calorias(trucha, 160).
calorias(bacalao, 300).
calorias(flan, 200).
calorias(nueces_con_miel, 500).
calorias(naranja, 50).

% plato_principal(P) P es un plato principal si es carne o pescado

plato_principal(P):- carne(P).
plato_principal(P):- pescado(P).

% comida(Entrada, Principal, Postre)

comida(Entrada, Principal, Postre):-
        entrada(Entrada),
        plato_principal(Principal),
        postre(Postre).
    
% Valor calorico de una comida

valor(Entrada, Principal, Postre, Valor):-
        calorias(Entrada, X),
        calorias(Principal, Y),
        calorias(Postre, Z),
        sumar(X, Y, Z, Valor).

% comida_equilibrada(Entrada, Principal, Postre)

comida_equilibrada(Entrada, Principal, Postre):-
        comida(Entrada, Principal, Postre),
        valor(Entrada, Principal, Postre, Valor),
        menor(Valor, 600).


% Conceptos auxiliares

sumar(X, Y, Z, Res):-
        Res is X + Y + Z.             % El predicado "is" se satisface si Res se puede unificar
                                      % con el resultado de evaluar la expresi�n X + Y + Z 
menor(X, Y):- 
        X < Y.                        % "menor" num�rico

dif(X, Y):-
        X =\= Y.                      % desigualdad num�rica 


% cuantas comidas llevan naranja de postre
%

comidas_con_naranja :-
	write("Comidas con naranja: "),
	aggregate_all(count,comida(_,_,naranja),X),
	write(X),
	nl.
