#lang racket

(require "interp.rkt")
(provide (all-defined-out))

;; interpret file.
(define (main fn)
  (with-input-from-file fn
    (lambda ()
      (let ((p (read)))
        (unless (integer? p) (error "syntax error" p))
        (writeln (interp p))))))
