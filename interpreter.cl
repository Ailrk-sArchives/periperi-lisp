(in-package #:periperi-lisp)
;; interpreter for perperi lisp.
;; The first step is to build the interpreter on common lisp to check
;; the semantics.

(defun interp (e)
  (declare (type integer e))
  e)

(defun main-interp ()
  (loop for n = (read) do
        (cond ((integerp n) (format t "~a~%" (interp n)))
              (t (error "syntax error")))))
