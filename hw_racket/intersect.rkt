#lang racket


(define(contains lst x)
  (cond
    [(null? lst) #f]
    [(equal? (car lst) x) #t]
    [#t (contains (cdr lst) x)]))

(define (insertEl lst x)
  (cond
    [(null? lst) (cons x null)]
    [(< x (car lst)) (cons x lst)]
    [(equal? x (car lst)) lst]
    [#t (cons (car lst) (insertEl (cdr lst) x))]))


(define (intersectAcc lst1 lst2 acc)
  (cond
    [(or (null? lst1) (null? lst2)) acc]
    [(contains lst1 (car lst2)) (intersectAcc lst1 (cdr lst2) (insertEl acc (car lst2)))]
    [#t (intersectAcc lst1 (cdr lst2) acc)]))

(define (intersect lst1 lst2)
  (intersectAcc lst1 lst2 null))