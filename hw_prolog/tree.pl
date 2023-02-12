% bt_identical(+-T1, +-T2)

bt_identical(empty, empty) :- !.
bt_identical(t(_, empty, empty), t(_, empty, empty)) :- !.
bt_identical(t(_, L1, empty), t(_, L2, empty)) :-
    bt_identical(L1, L2), !.
bt_identical(t(_, empty, R1), t(_, empty, R2)) :-
    bt_identical(R1, R2), !.
bt_identical(t(_, L1, R1), t(_, L2, R2)) :-
    bt_identical(R1, R2),
    bt_identical(L1, L2).