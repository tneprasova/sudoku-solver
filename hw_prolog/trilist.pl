my_split(Lst, A, B, C) :-
    length(Lst, L),
    L1 is L // 3,
    L2 is L - 2*L1,
    length(A, L1),
    length(B, L1),
    length(C, L2),
    append(A, B, Tmp),
    append(Tmp, C, Lst).

trilist([]) :- !.
trilist(L) :-
    my_split(L, A, B, C),
    A = B,
    B = C.