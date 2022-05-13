#| Mystery function |#

#lang racket

(provide mystery)

(define (mystery x) (if (zero? x) 1 (* x (mystery (sub1 x)))))
