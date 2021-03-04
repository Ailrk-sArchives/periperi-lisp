(in-package #:periperi-lisp)


; type Asm = [Instr]

; type Instr =
;   | 'ret
;   | `(move ,Arg ,Arg)
;   | Label

; type Arg =
;   | Reg
;   | Integer

; type Reg = | 'rax

(defun asmp (asm)
  (typep asm (list)))

(defun instrp (instr)
  (or (member instr '(ret))
      (eql )
      )
  )

(defun labelp (label)
  (symbolp label))

(defun argp (arg)
  (or (regp arg)
      (integerp arg)))

(defun regp (r)
  (member r '(rax)))

(defun compile-entry (e)
  `(entry
     (mov rax ,e)
     'ret))


; Asm -> String
(defun asm->string (asm)
  ())
