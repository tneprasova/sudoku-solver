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
matrixMapElem(Matrix, I, J, Value) :-
    length(Matrix, Len),
    nth0(I, Matrix, Row),
    nth0(J, Row, Value),
    mapValue(Len, Value),
    nth0(J, Row, Value).

% Get an element of a matrix on a given position
matrixGetElem(Matrix, I, J, Value) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Value).

% Generates a list of numbers in a given range, maximum excluded
genIndexes([], M, M) :- !.
genIndexes([Min|Is], Min, Max) :-
    plus(Min, 1, Next),
    genIndexes(Is, Next, Max).

% Generates a list of lists of indexes, which cuts the sudoku into n-wide columns (resp. n-wide rows)
getSquareIndexes([], _, [], _).
getSquareIndexes([_|T], In, [In|Is], SquareSize) :-
    maplist(plus(SquareSize), In, NewIndexes),
    getSquareIndexes(T, NewIndexes, Is, SquareSize).

% Genereates a list of lists, which represents the values in the subsquares
genSquares(SquareSize, Squares, Matrix) :-
    genIndexes(Indexes, 0, SquareSize),
    getSquareIndexes(Indexes, Indexes, AllIndexes, SquareSize),
    genSquares1(AllIndexes, AllIndexes, Matrix, Squares).

% genSquares1 and genSquares2 pass a cartesian product of the indexes to the following loop
% - it therefore covers the entire sudoku with the subquares
genSquares1([], _, _, []).
genSquares1([I|Is], J, Matrix, Squares) :-
    genSquares2(I, J, Matrix, S),
    append(S, Sqs, Squares),
    genSquares1(Is, J, Matrix, Sqs).

genSquares2(_, [], _, []).
genSquares2(I, [J|Js], Matrix, [Sq|Sqs]) :-
    genSquares3(I, J, Sq, Matrix),
    genSquares2(I, Js, Matrix, Sqs).

% genSquares3 and genSquares4 iterate through the given indexes (representing a certain subsquare)
% and return a list of values it contains
genSquares3([], _, [], _).
genSquares3([I|Is], J, Squares, Matrix) :-
    genSquares4(I, J, S, Matrix),
    append(S, Sqs, Squares),
    genSquares3(Is, J, Sqs, Matrix).

genSquares4(_, [], [], _).
genSquares4(I, [J|Js], [Val|Vs], Matrix) :-
    matrixGetElem(Matrix, I, J, Val),
    genSquares4(I, Js, Vs, Matrix).

solve(Matrix) :-
    length(Matrix, Len),
    genIndexes(Indexes, 0, Len),
    round(sqrt(Len), SquareSize),
    genSquares(SquareSize, Squares, Matrix),
    outerLoop(Matrix, Indexes, Indexes, Squares).

outerLoop(_, [], _, _).
outerLoop(Matrix, [I|Is], J, Squares) :-
    innerLoop(Matrix, I, J, Squares),
    outerLoop(Matrix, Is, J, Squares).

innerLoop(_, _, [], _).
innerLoop(Matrix, I, [J|Js], Squares) :-
    % Try a number on a given position
    matrixMapElem(Matrix, I, J, _),
    
    % Check the sudoku
    maplist(are_unique, Matrix),
    transpose(Matrix, Columns),
    maplist(are_unique, Columns),
    maplist(are_unique, Squares),

    innerLoop(Matrix, I, Js, Squares).


% The main function
sudoku(Rows):-
    % Check the dimensions
    maplist(same_length(Rows), Rows),
    length(Rows, Len),
    sqrt(Len, Sqrt),
    Len =:= Sqrt * Sqrt,

    solve(Rows),

    writeln(">>"),
    maplist(writeln, Rows).