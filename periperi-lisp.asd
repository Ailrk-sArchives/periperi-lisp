;;;; periperi-lisp.asd

(asdf:defsystem #:periperi-lisp
  :description "A compiler/interpreter for periperi-lisp"
  :author "Your Name <jimmy123good@homtail.com>"
  :license  "MIT"
  :version "0.0.1"
  :components
  ((:file "package")
   (:file "peri-peri-lisp")
   (:file "x86-codegen")
   (:file "interpreter")
   (:file "compiler")))
