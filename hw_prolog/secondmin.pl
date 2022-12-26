my_delete([], _, []) :- !.
my_delete([E], E, []) :- !.
my_delete([H|T], E, Res) :-
    H = E,
    my_delete(T, E, Res), !.
my_delete([H|T], E, [H|Res]) :-
    my_delete(T, E, Res).

find_second_min([], 1.0Inf, 1.0Inf) :- !.
find_second_min([H|T], H, R2) :-
    find_second_min(T, R1, R2),
    H =< R1, !.
find_second_min([H|T], R1, H) :-
    find_second_min(T, R1, R2),
    H > R1,
    H =< R2, !.
find_second_min([H|T], R1, R2) :-
    find_second_min(T, R1, R2),
    H > R1.

%without_second_min(+Lst, -Res)
without_second_min([], _) :- fail, !.
without_second_min([_], _) :- fail, !.
without_second_min(Lst, Res) :-
    find_second_min(Lst, _, B),
    B \= 1.0Inf,
    my_delete(Lst, B, Res).