#lang racket

(define (isBalanced x y)
  (cond
    [(> (- y x) 1) #f]
    [(< (- y x) -1) #f]
    [#t #t]))

(define (myMax x y)
  (if (< x y)
      y
      x))

(define (treeHeight tree)
  (if (null? tree)
       0
    (myMax (+ 1 (treeHeight (cadr tree))) (+ 1 (treeHeight (caddr tree))))))

(define (is-balanced? tree)
  (if (null? tree)
      #t
      (if (and #t (isBalanced (treeHeight (cadr tree)) (treeHeight (caddr tree))))
          (and (is-balanced? (cadr tree)) (is-balanced? (caddr tree)))
          #f)))