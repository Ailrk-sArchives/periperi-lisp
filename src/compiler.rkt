#lang racket
(provide (all-defined-out))

;; printer

; type Asm = [Listof Instruction]

; type Instruction =
; | 'ret
; | '(mov ,Arg ,Arg)
; | '(add ,Arg ,Arg)
; | '(sub ,Arg ,Arg)
; | Label

; type Label = Symbol

; type Expr =
; | integer
; | '(add1 ,Expr)
; | '(sub1 ,Expr)

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
    (`(add ,a1 ,a2)
      (string-append "\tadd "
                     (arg->string a1)
                     ", "
                     (arg->string a2) "\n"))
    (`(sub ,a1 ,a2)
      (string-append "\tsub "
                     (arg->string a1)
                     ", "
                     (arg->string a2) "\n"))
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

(define (compile-e e)
  (match e
    ((? integer? i) `(mov rax ,i))
    (`(add1 ,e0)
      (let ((c0 (compile-e e0)))
        `(,@c0
           (add rax 1))))
    (`(sub1 ,e0)
      (let ((c0 (compile-e e0)))
        `(,@c0
           (sub rax 1))))))

(define (compile e)
  (append '(entry)
          (compile-e e)
          '(ret)))
