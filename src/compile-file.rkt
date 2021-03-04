#lang racket

(provide (all-defined-out))
(require "compiler.rkt")

;; entrance

(define (main fn)
  (with-input-from-file fn
    (lambda ()
      (let ((p (read)))
        (unless (integer? p) (error "pplisp: syntax error" p))
        (display-asm (compile p))))))
