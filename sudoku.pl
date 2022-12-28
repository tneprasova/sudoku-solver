% Check unique values in a list
are_unique(Row) :-
    list_to_set(Row, Set),
    length(Row, A),
    length(Set, A).

% Set values, 0 or _ is considered to be an empty field
mapValue(_, V, V) :- V \= 0, !.
mapValue(Max, _, Res) :-
    between(1, Max, Res).

mapValues([], _, _).
mapValues([T|H], [R|Rs], Max) :-
    maplist(mapValue(Max), T, R),
    mapValues(H, Rs, Max).

% Transpose a matrix
transpose([M|Ms], Res) :-
    transpose(M, [M|Ms], Res).

transpose([], _, []).
transpose([_|Ms], Matrix, [Row|Rs]) :-
    first_column_to_row(Matrix, Row, Matrix_minus_column),
    transpose(Ms, Matrix_minus_column, Rs).

first_column_to_row([], [], []).
first_column_to_row([[F|RestOfRow]|RestOfRows], [F|Fs], [RestOfRow|Rs]) :-
    first_column_to_row(RestOfRows, Fs, Rs).



% The main function
sudoku(Rows, Res):-
    % Check the dimensions (is a square)
    maplist(same_length(Rows), Rows),
    
    % Try to map values
    length(Rows, Len),
    length(NewRows, Len),
    mapValues(Rows, NewRows, Len),

    % Check, whether the values were correctly mapped
    maplist(are_unique, NewRows),
    transpose(NewRows, Columns),
    maplist(are_unique, Columns),
    transpose(Columns, Res),

    % Output
    writeln(">>"),
    maplist(writeln, Res).