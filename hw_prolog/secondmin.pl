my_delete([], _, []).
my_delete([E], E, []).
my_delete([H|T], E, Res) :-
    H = E,
    my_delete(T, E, Res), !.
my_delete([H|T], E, [H|Res]) :-
    my_delete(T, E, Res).

find_min([A], A) :- !.
find_min([H|T], H) :-
    find_min(T, R),
    H =< R, !.
find_min([H|T], R) :-
    find_min(T, R),
    H > R.

%without_second_min(+Lst, -Res)
without_second_min([], _) :- fail.
without_second_min([_], _) :- fail.
without_second_min(Lst, Res) :-
    find_min(Lst, A),
    my_delete(Lst, A, Tmp),
    find_min(Tmp, B),
    my_delete(Lst, B, Res).