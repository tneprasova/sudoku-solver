% Check unique values in a list
are_unique(Res) :-
    is_set(Res).

% Set values, undescore is an empty field
mapValue(Max, Value) :-
    between(1, Max, Value).

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

% If given element of the matrix is empty, try to replace it with a number
matrixMapElem(Matrix, I, J) :-
    length(Matrix, Len),
    nth0(I, Matrix, Row),
    nth0(J, Row, Value),
    mapValue(Len, Value),
    nth0(J, Row, Value).

% Checks the sub squares of the sudoku
checkSquares([], [], []).
checkSquares([V1, V2, V3|Vs1], [V4, V5, V6|Vs2], [V7, V8, V9|Vs3]) :-
        are_unique([V1, V2, V3, V4, V5, V6, V7, V8, V9]),
        checkSquares(Vs1, Vs2, Vs3).

genIndexes([], M, M) :- !.
genIndexes([Min|Is], Min, Max) :-
    plus(Min, 1, Next),
    genIndexes(Is, Next, Max).

solve(Matrix) :-
    length(Matrix, Len),
    genIndexes(Indexes, 0, Len),
    outerLoop(Matrix, Indexes, Indexes).

outerLoop(_, [], _).
outerLoop(Matrix, [I|Is], J) :-
    innerLoop(Matrix, I, J),
    outerLoop(Matrix, Is, J).

innerLoop(_, _, []).
innerLoop(Matrix, I, [J|Js]) :-
    % Try a number on a given position
    matrixMapElem(Matrix, I, J),
    
    % Check the sudoku
    maplist(are_unique, Matrix),
    transpose(Matrix, Columns),
    maplist(are_unique, Columns),
    Matrix = [A,B,C,D,E,F,G,H,K],
    checkSquares(A,B,C),
    checkSquares(D,E,F),
    checkSquares(G,H,K),

    innerLoop(Matrix, I, Js).


% The main function
sudoku(Rows):-
    % Check the dimensions (is a square)
    maplist(same_length(Rows), Rows),
    
    solve(Rows),

    writeln(">>"),
    maplist(writeln, Rows).