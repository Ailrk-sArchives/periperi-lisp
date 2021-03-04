#lang racket
(provide (all-defined-out))

(define (interp e)
  (integer? e) e)
