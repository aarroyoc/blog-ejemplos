:- use_module(library(clpz)).
:- use_module(library(format)).

moving(Vars, EndTime) :-
    Vars = [StartPiano, EndPiano, StartBed, EndBed, StartTable, EndTable, StartTV, EndTV,
	    StartChair1, StartChair2, StartChair3, StartChair4, EndChair1, EndChair2, EndChair3, EndChair4,
	    StartShelf1, StartShelf2, EndShelf1, EndShelf2],
    Vars ins 0..100,
    % Tasks
    Tasks = [
	task(StartPiano, 30, EndPiano, 3, _),
	task(StartBed, 20, EndBed, 3, _),
	task(StartTable, 15, EndTable, 2, _),
	task(StartTV, 15, EndTV, 2, _),
	task(StartChair1, 10, EndChair1, 1, _),
	task(StartChair2, 10, EndChair2, 1, _),
	task(StartChair3, 10, EndChair3, 1, _),
	task(StartChair4, 10, EndChair4, 1, _),
	task(StartShelf1, 15, EndShelf1, 2, _),
	task(StartShelf2, 15, EndShelf2, 2, _)
    ],
    % Must be moved before
    EndBed #< StartPiano,
    EndTV #< StartTable,
    EndShelf1 #< StartBed,
    EndShelf2 #< StartTable,

    % EndTime
    end_time(EndTime, [EndPiano, EndBed, EndTable, EndTV, EndChair1, EndChair2, EndChair3, EndChair4, EndShelf1, EndShelf2]),
    % Cumulative constraint
    cumulative(Tasks, [limit(4)]),

    % Find solution
    labeling([min(EndTime)], Vars).

end_time(EndTime, [EndTime]).
end_time(EndTime, [X|Xs]) :-
    end_time(EndTime0, Xs),
    EndTime #= max(X, EndTime0).


run :-
    moving([StartPiano, EndPiano, StartBed, EndBed, StartTable, EndTable, StartTV, EndTV,
	    StartChair1, StartChair2, StartChair3, StartChair4, EndChair1, EndChair2, EndChair3, EndChair4,
	    StartShelf1, StartShelf2, EndShelf1, EndShelf2], EndTime),
    format("Optimal time: ~d~n", [EndTime]),
    format("Piano   ~d  ~d~n",[StartPiano, EndPiano]),
    format("Bed     ~d  ~d~n",[StartBed, EndBed]),
    format("Table   ~d  ~d~n",[StartTable, EndTable]),
    format("TV      ~d  ~d~n",[StartTV, EndTV]),
    format("Chair 1 ~d  ~d~n",[StartChair1, EndChair1]),
    format("Chair 2 ~d  ~d~n",[StartChair2, EndChair2]),
    format("Chair 3 ~d  ~d~n",[StartChair3, EndChair3]),
    format("Chair 4 ~d  ~d~n",[StartChair4, EndChair4]),
    format("Shelf 1 ~d  ~d~n",[StartShelf1, EndShelf1]),
    format("Shelf 2 ~d  ~d~n",[StartShelf2, EndShelf2]).
