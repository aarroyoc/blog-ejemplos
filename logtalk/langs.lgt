:- protocol(langp).

    :- public(say_creator/0).

:- end_protocol.

:- object(python, implements(langp)).

    say_creator :-
        write('Created by: Guido van Rossum'),nl.

:- end_object.

:- object(animal).

    :- public(run/0).
    run :-
        write('Animal is running'),nl.

:- end_object.

:- object(dog, extends(animal)).

    :- public(run/0).
    run :-
        write('Dog is running'),nl,
        ^^run.

    :- public(sleep/0).
    sleep :-
        write('Dog is sleeping'),nl.

    :- public(run_and_sleep/0).
    run_and_sleep :-
        self(Self),
        Self::run,
        Self::sleep.
:- end_object.

:- category(reverse_creator(_Creator_)).

    :- uses(list, [reverse/2]).

    :- public(reverse_creator/1).
    reverse_creator(Reversed) :-
        reverse(_Creator_, Reversed).

:- end_category.

:- object(ruby(CreatorParam), implements(langp), imports(reverse_creator(CreatorParam))).
    
    say_creator :-
        write('Created by: '),
        parameter(1, Creator),
        write(Creator),nl.
        
:- end_object.