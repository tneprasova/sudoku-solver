# Sudoku solver
My implementation is able to solve a random sudoku with the size of deskboard being $`({n^2*n^2|n\geq 1})`$
and finds all of the solutions.

## Usage
Run the program with:
```swipl sudoku.pl```

Then run the solver with:
```sudoku(<your sudoku>).```

The sudoku is represented as a matrix - a list of rows, to be exact.
For more info about using the solver, look into the examples.