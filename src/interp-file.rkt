#lang racket

(provide (all-defined-out))
(require "interp.rkt")

;; interpret file.
(define (main fn)
  (with-input-from-file fn
    (lambda ()
      (let ((p (read)))
        (unless (integer? p) (error "syntax error" p))
        (writeln (interp p))))))
