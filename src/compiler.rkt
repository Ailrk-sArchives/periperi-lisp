#lang racket
(provide (all-defined-out))

;; printer

; type Asm = [Listof Instruction]

; type Instruction =
; | ‘ret
; | ‘(mov ,Arg ,Arg)
; | Label

; type Label = Symbol

; type Arg =
; | Reg
; | Integer

; type Reg =
; | ‘rax

(define (label? l) (symbol? l))

;; Asm -> String
(define (asm->string asm)
  (foldr (lambda (i s)
           (string-append (instr->string i) s)) "" asm))

;; Instruction -> String
(define (instr->string i)
  (match i
    (`(move ,a1 ,a2)
      (string-append
        "\tmov " (arg->string a1) ", " (arg->string a2) "\n"))
    ('ret "\tret\n")
    (label (string-append (label->string label) ":\n"))))

;; Arg -> String
(define (arg->string arg)
  (match arg
    ('rax "rax")
    (n (number->string n))))

;; Asm -> String
(define label->string
  ;; handle macos
  (match (system-type 'os)
    ('macosx (lambda (s) (string-append "_" s)))
    (_ symbol->string)))

(define (display-asm asm)
  ;; add entry point. the first label is the entry.
  (let ((g (findf label? asm)))
    (display
      (string-append "\tglobal " (label->string g) "\n"
                     "\tsection .text\n"
                     (asm->string asm)))))

;; (display-asm (compile 3))

(define (compile e)
  `(entry
     (move rax ,e)
     ret))
