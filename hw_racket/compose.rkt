#lang racket

(define (compose-chain lst)
  (if (null? lst)
      (lambda (x) x)
  (lambda (x) ((car lst) ((compose-chain (cdr lst)) x)))))