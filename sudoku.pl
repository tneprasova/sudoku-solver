is_row_unique(Row) :-
    list_to_set(Row, Set),
    length(Row, A),
    length(Set, B),
    A = B.

% Check dimensions and unique values in the rows
checkRows(S) :-
    length(S, L),
    checkRows(S, L).
checkRows([R], L1) :- 
    is_row_unique(R),
    length(R, L2),
    L1 = L2,
    maplist(between(1, L1), R).
checkRows([R|T], L1) :-
    is_row_unique(R),
    length(R, L2),
    L1 = L2,
    checkRows(T, L1),
    maplist(between(1, L1), R).

sudoku(S):-
    checkRows(S).