:- use_module(library(random)).

init :-
    use_foreign_library('target/debug/libgglog.so'),
    init_raylib(600, 400, "RayLog"),
    loop.

loop :-
    \+ should_close,
    !,
    begin_drawing,
    random_between(128, 255, Red),
    random_between(128, 255, Green),
    random_between(128, 255, Blue),
    clear_background(color(Red, Green, Blue, 255)),
    draw_text("Raylib + Prolog =:= Fun", 12, 12, 20, color(0, 0, 0, 255)),
    end_drawing,
    loop.

loop :-
    halt(0).