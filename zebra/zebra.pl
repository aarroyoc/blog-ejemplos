:- use_module(library(clpz)).
:- use_module(library(lists)).
:- use_module(library(format)).

run :-
    zebra(Vars),
    append([English,Spanish,Japanese,Norwegian,Italian|_], [Zebra], Vars),
    Nats = [English-english, Spanish-spanish, Japanese-japanese, Norwegian-norwegian, Italian-italian],
    member(Zebra-Nat, Nats),
    format("The ~a has the zebra~n", [Nat]),
    nth0(14, Vars, Water),
    member(Water-Nat1, Nats),
    format("The ~a has the water~n", [Nat1]).
    

zebra(Vars) :-
    Vars = [
	% nationalities
	English, Spanish, Japanese, Norwegian, Italian,
	% professiones
	Painter, Doctor, Diplomat, Violinist, Sculptor,
	% beverages
	Tea, Coffee, Juice, Milk, Water,
	% colors
	Red, Green, White, Yellow, Blue,
	% animals
	Dog, Snails, Fox, Horse, Zebra],
    Vars ins 1..5,

    all_different([English, Spanish, Japanese, Norwegian, Italian]),
    all_different([Painter, Doctor, Diplomat, Violinist, Sculptor]),
    all_different([Tea, Coffee, Juice, Milk, Water]),
    all_different([Red, Green, White, Yellow, Blue]),
    all_different([Dog, Snails, Fox, Horse, Zebra]),

    English #= Red,
    Spanish #= Dog,
    Japanese #= Painter,
    Italian #= Tea,
    Norwegian #= 1,
    Green #= Coffee,
    Green #= White + 1,
    Sculptor #= Snails,
    Diplomat #= Yellow,
    Milk #= 3,
    abs(Norwegian-Blue) #= 1,
    Violinist #= Juice,
    abs(Fox-Doctor) #= 1,
    abs(Horse-Diplomat) #= 1,
    
    label(Vars).
