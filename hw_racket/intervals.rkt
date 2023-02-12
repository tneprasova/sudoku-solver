#lang racket

(define (areOverlapped in1 in2)
  (cond
    [(or (null? in1) (null? in2)) #f]
    [(and (< (car in1) (car in2)) (< (cadr in1) (car in2))) #f]
    [(and (> (car in1) (car in2)) (< (cadr in2) (car in1))) #f]
    [#t #t]))

(define (numOver lst intrv)
  (cond
    [(or (null? intrv) (null? lst)) 0]
    [(areOverlapped (car lst) intrv) (+ 1 (numOver (cdr lst) intrv))]
    [#t (numOver (cdr lst) intrv)]))

(define (lstMinus lst x)
  (if (equal? x (car lst))
      (cdr lst)
      (cons (car lst) (lstMinus (cdr lst) x))))

(define (concatIntrv lst x)
  (cons (lstMinus lst x) (cons x null)))

(define (makeInput lst curr)
  (if (null? curr)
      null
      (cons (concatIntrv lst (car curr)) (makeInput lst (cdr curr)))))

(define (intervals lst)
  (if (null? lst)
      null
      (map (lambda (x) (numOver (car x) (cadr x))) (makeInput lst lst))))