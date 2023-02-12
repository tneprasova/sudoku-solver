is_member([A], A) :- !.
is_member([H|_], A) :-
    H = A.
is_member([_|T], A) :-
    is_member(T, A).

%values_in(+-Values, +Universe)
values_in([], []).
values_in([], [_|_]).
values_in([A], [A]).
values_in([H|T], Uni) :-
    is_member(Uni, H),
    values_in(T, Uni).