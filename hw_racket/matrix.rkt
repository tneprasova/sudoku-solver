#lang racket

(define (mulLst lst1 lst2)
  (if (null? lst1)
      0
      (+ (* (car lst1) (car lst2)) (mulLst (cdr lst1) (cdr lst2)))))

(define (lstToElems lst)
  (if (null? lst)
      null
      (cons (cons (car lst) null) (lstToElems (cdr lst)))))

(define (rowsToElems matrix)
  (if (null? matrix)
      null
  (cons (lstToElems (car matrix)) (rowsToElems  (cdr matrix)))))

(define (myAppend x lst)
  (if (null? lst)
      (cons x null)
      (cons (car lst) (myAppend x (cdr lst)))))

(define (lstAppend lst1 lst2)
  (if (null? lst2)
      lst1
      (lstAppend (myAppend (car lst2) lst1) (cdr lst2))))

(define (mergeLsts lst init)
  (if (null? lst)
      null
      (cons (lstAppend (car init) (car lst)) (mergeLsts (cdr lst) (cdr init)))))

(define (oneDim lst)
  (if (null? (cdar lst))
      lst
      (lstToElems (car lst))))
      

(define (rowsToCols matrix)
  (if (null? (cdr matrix))
      (oneDim matrix)
      (foldl mergeLsts (lstToElems (car matrix)) (map lstToElems (cdr matrix)))))

(define (rowMatrixMul row matrix)
  (if (null? matrix)
      null
      (cons (mulLst row (car matrix)) (rowMatrixMul row (cdr matrix)))))

(define (matrix-mul mx1 mx2)
  (if (null? mx1)
      null
      (cons (rowMatrixMul (car mx1) (rowsToCols mx2)) (matrix-mul (cdr mx1) mx2))))