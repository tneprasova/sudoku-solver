# Sudoku solver
This implementation is able to solve a random sudoku with deskboard size being $(n^2*n^2\space |\space n\geq 1,\space n\in\mathbb{N})$.

It finds all of the solutions, if they exist or identifies an invalid sudoku.

## Prerequisites
You will need SWI Prolog.

Linux (Ubuntu):
```
sudo apt-get install swi-prolog
```

Windows and Mac: https://www.swi-prolog.org/download/stable

## Usage
Run the program with:
```
swipl sudoku.pl
```

Then run the solver with:
```
sudoku(<your sudoku>).
```

### Note
The sudoku is represented as a matrix of numbers or blank spaces - a list of matrix rows, to be precise.
For more information about using the solver and the input formatting, look into the examples.
