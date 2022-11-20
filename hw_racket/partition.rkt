#lang racket

(define (evalLst f acc x)
  (cond
    [(equal? (f x) #t) (cons (cons x (car acc)) (cdr acc))]
    [(equal? (f x) #f) (cons (car acc) (cons (cons x (car(cdr acc))) null))]))


(define (myFoldl f pred init lst)
  (if (null? lst)
      init
      (f pred (myFoldl f pred init (cdr lst)) (car lst))))

(define (partition-by f lst)
  (myFoldl evalLst f '(() ()) lst))