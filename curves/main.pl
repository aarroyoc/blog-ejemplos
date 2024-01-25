:- use_module(library(dcgs)).
:- use_module(library(clpz)).
:- use_module(library(format)).
:- use_module(library(pio)).
:- use_module(library(si)).
:- use_module(library(lists)).
:- use_module(library(debug)).


clpz:monotonic.

main :-
    phrase_to_file(hilbert_all(["black", "blue", "green", "red", "yellow"]), "hilbert.svg").

hilbert_all(Colors) -->
    {
	length(Colors, H),
	hilbert_width(H, Width),
	#W1 #= Width + 20,
	phrase(format_("-10 -10 ~d ~d", [W1, W1]), ViewBox),
	Colors = [Color|Colors1]
    },
    tag(svg, [version("1.1"), width(Width), height(Width), viewBox(ViewBox), xmlns("http://www.w3.org/2000/svg")],(
	    hilbert_a(H, 1, Width, 0, Width, Width, Color),
	    hilbert_sub(Colors1, 1, Width))
       ).

hilbert_sub([], _, _) --> [].
hilbert_sub(Colors, F, TotalWidth) -->
    {
	length(Colors, N),
	#F1 #= F * 2,
	hilbert_width(N, Width),
	#FWidth #= Width * F1,
	#HalfF #= (TotalWidth - FWidth) / 2,
	phrase(format_("translate(~d, ~d)", [HalfF, HalfF]), Transform),
	Colors = [Color|Colors1]
    },
    tag(g, [transform(Transform)], hilbert_a(N, F1, FWidth, 0, FWidth, FWidth, Color)),
    hilbert_sub(Colors1, F1, TotalWidth).

hilbert_width(1, 8).
hilbert_width(H, N) :-
    #H1 #= H - 1,
    hilbert_width(1, Base),
    hilbert_width(H1, N1),
    #N #= N1*2 + Base.

hilbert_only(H) -->
    { hilbert_width(H, Width) },
    tag(svg, [version("1.1"), width(Width), height(Width), xmlns("http://www.w3.org/2000/svg")], hilbert_a(H, 1, Width, 0, Width, Width, "black")).

hilbert_a(1, F, X0, Y0, X0, Y, Color) -->
    { #X #= X0 - 8 * F, #Y #= Y0 + 8 * F },
    line(X0, Y0, X, Y0, Color),
    line(X, Y0, X, Y, Color),
    line(X, Y, X0, Y, Color).

hilbert_a(H, F, X0, Y0, X0, Y, Color) -->
    { #H1 #= H - 1, #X2 #= #X1 - 8 * F, #Y3 #= #Y2 + 8 * F},
    hilbert_b(H1, F, X0, Y0, X1, Y1, Color),
    line(X1, Y1, X2, Y1, Color),
    hilbert_a(H1, F, X2, Y1, X3, Y2, Color),
    line(X3, Y2, X3, Y3, Color),
    hilbert_a(H1, F, X3, Y3, X4, Y4, Color),
    line(X4, Y4, X1, Y4, Color),
    hilbert_c(H1, F, X1, Y4, X0, Y, Color).

hilbert_b(1, F, X0, Y0, X, Y0, Color) -->
    { #X #= X0 - 8 * F, #Y #= Y0 + 8 * F},
    line(X0, Y0, X0, Y, Color),
    line(X0, Y, X, Y, Color),
    line(X, Y, X, Y0, Color).

hilbert_b(H, F, X0, Y0, X, Y0, Color) -->
    { #H1 #= H - 1, #Y2 #= #Y1 + 8 * F, #X3 #= #X2 - 8 * F},
    hilbert_a(H1, F, X0, Y0, X1, Y1, Color),
    line(X1, Y1, X1, Y2, Color),
    hilbert_b(H1, F, X1, Y2, X2, Y3, Color),
    line(X2, Y3, X3, Y3, Color),
    hilbert_b(H1, F, X3, Y3, X, Y4, Color),
    line(X, Y4, X, Y1, Color),
    hilbert_d(H1, F, X, Y1, X, Y0, Color).

hilbert_c(1, F, X0, Y0, X, Y0, Color) -->
    { #X #= X0 + 8 * F, #Y #= Y0 - 8 * F },
    line(X0, Y0, X0, Y, Color),
    line(X0, Y, X, Y, Color),
    line(X, Y, X, Y0, Color).

hilbert_c(H, F, X0, Y0, X, Y0, Color) -->
    { #H1 #= H - 1, #Y2 #= #Y1 - 8 * F, #X3 #= #X2 + 8 * F},
    hilbert_d(H1, F, X0, Y0, X1, Y1, Color),
    line(X1, Y1, X1, Y2, Color),
    hilbert_c(H1, F, X1, Y2, X2, Y3, Color),
    line(X2, Y3, X3, Y3, Color),
    hilbert_c(H1, F, X3, Y3, X, Y4, Color),
    line(X, Y4, X, Y1, Color),
    hilbert_a(H1, F, X, Y1, X, Y0, Color).

hilbert_d(1, F, X0, Y0, X0, Y, Color) -->
    { #X #= X0 + 8 * F, #Y #= Y0 - 8 * F},
    line(X0, Y0, X, Y0, Color),
    line(X, Y0, X, Y, Color),
    line(X, Y, X0, Y, Color).

hilbert_d(H, F, X0, Y0, X0, Y, Color) -->
    { #H1 #= H - 1, #X2 #= #X1 + 8 * F, #Y3 #= #Y2 - 8 * F},
    hilbert_c(H1, F, X0, Y0, X1, Y1, Color),
    line(X1, Y1, X2, Y1, Color),
    hilbert_d(H1, F, X2, Y1, X3, Y2, Color),
    line(X3, Y2, X3, Y3, Color),
    hilbert_d(H1, F, X3, Y3, X4, Y4, Color),
    line(X4, Y4, X1, Y4, Color),
    hilbert_b(H1, F, X1, Y4, X0, Y, Color).

    
line(X1, Y1, X2, Y2, Color) -->
    closed_tag(line, [x1(X1), x2(X2), y1(Y1), y2(Y2), stroke(Color), 'stroke-width'("1")]).

tag(T, GRBody) -->
    format_("<~w>", [T]),
    GRBody,
    format_("</~w>", [T]).
    
tag(T, Attrs, GRBody) -->
    format_("<~w", [T]),
    tag_attrs(Attrs),
    ">",
    GRBody,
    format_("</~w>", [T]).

closed_tag(T, Attrs) -->
    format_("<~w", [T]),
    tag_attrs(Attrs),
    "/>".

tag_attrs([]) --> "".
tag_attrs([Attr|Attrs]) -->
    { Attr =.. [Name, Value], chars_si(Value) },
    format_(" ~w=\"", [Name]),
    Value,
    "\"",
    tag_attrs(Attrs).
tag_attrs([Attr|Attrs]) -->
    { Attr =.. [Name, Value], integer_si(Value) },
    format_(" ~w=\"~d\"", [Name, Value]),
    tag_attrs(Attrs).
