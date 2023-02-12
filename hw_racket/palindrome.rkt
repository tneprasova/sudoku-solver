#lang racket

(define (myLen lst)
  (if (null? lst)
      0
      (+ 1 (myLen(cdr lst)))))

(define (removeEnd lst)
  (if (<= (myLen lst) 1)
      null
      (cons (car lst) (removeEnd (cdr lst)))))

(define (removeEnds lst)
  (if (<= (myLen lst) 2)
      null
      (removeEnd (cdr lst))))

(define (myAppend x lst)
  (if (null? lst)
      (cons x null)
      (cons (car lst) (myAppend x (cdr lst)))))

(define (myRev lst)
  (if (null? lst)
      null
      (myAppend (car lst) (myRev (cdr lst)))))

(define (is-palindrome? p)
  (if (null? p)
      #t
      (equal? (removeEnds p) (myRev (removeEnds p)))))