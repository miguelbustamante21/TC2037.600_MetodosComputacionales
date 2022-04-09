#|
Simple implementation of a Deterministic Finite Automaton
Identify all the token types found in the input string
Return a list of tokens found
Used to validate input strings
Example calls:
(automaton-2 (dfa-str 'start '(int var) delta-arithmetic-1) "34+9/du*23123")

Miguel Bustamante A01781583
Emilio Sibaja Villarreal A01025139

2022-03-18
|#

#lang racket

(require racket/trace)

(provide arithmetic-lexer)

; Structure that describes a Deterministic Finite Automaton
(struct dfa-str (initial-state accept-states transitions))

(define (arithmetic-lexer input-string)
  " Entry point for the lexer "
  ;final states that can be accepted 
  (automaton-2 (dfa-str 'start '(int var float exp par_close comm) delta-arithmetic-1) input-string))

(define (automaton-2 dfa input-string)
  " Evaluate a string to validate or not according to a DFA.
  Return a list of the tokens found"
  (trace-let loop
    ([state (dfa-str-initial-state dfa)]    ; Current state
     [chars (string->list input-string)]    ; List of characters
     [token_value null]
     [result null])                         ; List of tokens found
    (if (empty? chars)
      ; Check that the final state is in the accept states list
      ;(member state (dfa-str-accept-states dfa))
      (if (member state (dfa-str-accept-states dfa))
        (reverse (cons (list (list->string (reverse token_value))state) result)) #f)
      ; Recursive loop with the new state and the rest of the list
      (let-values
        ; Get the new token found and state by applying the transition function
        ([(token state) ((dfa-str-transitions dfa) state (car chars))])
        (loop
          state
          (cdr chars)
          (cond
            [token (if (char-whitespace? (car chars)) null (list(car chars)))]
            [(not (char-whitespace? (car chars))) (cons (car chars) token_value)]
            )
          ; Update the list of tokens found
          (if token (cons (list (list->string (reverse token_value)) token) result) result))))))


(define (operator? char)
    (member char '(#\+ #\- #\* #\/ #\^ #\=)))

(define (sign? char)
    (member char '(#\+ #\-) ))

(define (par_open? char)
    (member char ' (#\( ) ))

(define (par_close? char)
    (member char ' (#\) ) ))

(define (o_space? char)
    (member char ' (#\space)))

(define (n_space? char)
    (member char ' (#\space)))

(define (pre_comment? char)
    (member char ' (#\/ ) ))

(define (comment? char)
    (member char ' (#\/ ) ))

(define (be_exp? char)
    (member char '(#\E #\e )))

(define (dot? char)
    (member char '(#\. )))

(define (delta-arithmetic-1 state character)
  " Transition to identify basic arithmetic operations "
  (case state
    ['start (cond
              [(char-numeric? character) (values #f 'int)]
              [(sign? character) (values #f 'n_sign)]
              [(or (char-alphabetic? character) (eq? character #\_)) 
              (values #f 'var)]
              [(par_open? character) (values #f 'par_open)]
              [(pre_comment? character) (values #f 'pre_comm)]
              [(o_space? character) (values #f 'oSpace)]
              [else (values #f 'fail)])]

    ['n_sign (cond
               [(char-numeric? character) (values #f 'int)]
               [(pre_comment? character) (values #f 'pre_comm)]
               [else (values #f 'fail)])]

    ['int (cond
              [(char-numeric? character) (values #f 'int)]
              [(operator? character) (values 'int 'op)]
              [(dot? character) (values #f 'dot)]
              [(par_close? character) (values 'int 'par_close)]
              [(n_space? character) (values 'int 'nSpace)]
              [(be_exp? character) (values #f 'exp)]
              [else (values #f 'fail)])]
    ['var (cond
            [(or (char-alphabetic? character) (eq? character #\_)) 
            (values #f 'var)]
            [(char-numeric? character) (values #f 'var)]
            [(operator? character) (values 'var 'op)]
            [(par_close? character) (values #f 'par_close)]
            [(n_space? character) (values #f 'nSpace)]
            [else (values #f 'fail)])]
    ['op (cond
           [(char-numeric? character) (values 'op 'int)]
           [(sign? character) (values 'op 'n_sign)]
           [(o_space? character) (values 'op 'oSpace)]
           [(par_open? character) (values #f 'par_open)]
           [(comment? character) (values 'op 'comm)]
           [(or (char-alphabetic? character) (eq? character #\_)) (values 'op 'var)]
           [else (values #f 'fail)])]

    ['dot (cond
          [(char-numeric? character) (values #f 'float)]
          [else (values #f 'fail)])]

    ['float(cond
          [(char-numeric? character) (values #f 'float)]
          [(be_exp? character) (values #f 'exp)]
          [(n_space? character) (values 'float 'nSpace)]
          [(operator? character) (values 'float 'op)]
          [else (values #f 'fail)])]

    ['pre_comm(cond
          [(comment? character) (values #f 'comm)]
          [else (values #f 'fail)])]

    ['comm(cond
          [(comment? character) (values 'comm 'comm)]
          [else (values 'comm 'comm)])]
    
    ['oSpace(cond
          [(char-numeric? character) (values #f 'int)]
          [(sign? character) (values #f 'n_sign)]
          [(pre_comment? character) (values #f 'pre_comm)]
          [(o_space? character) (values #f 'oSpace)]
          [(par_open? character) (values #f 'par_open)]
          [else (values #f 'fail)])]

    ['nSpace(cond
          [(par_close? character) (values #f 'par_close)]
          [(operator? character) (values #f 'op)]
          [(n_space? character) (values #f 'nSpace)]
          [else (values #f 'fail)])]

    ['par_open(cond
          [(char-numeric? character) (values 'par_open 'int)]
          [(or (char-alphabetic? character) (eq? character #\_)) (values 'par_open 'var)]
          [(o_space? character) (values 'par_open 'oSpace)]
          [(pre_comment? character) (values 'par_open 'pre_comm)]
          [else (values #f 'fail)])]

    ['par_close(cond
          [(operator? character) (values 'par_close 'op)]
          [(n_space? character) (values 'par_close 'nSpace)]
          [else (values #f 'fail)])]

          
    ['be_exp(cond
          [(be_exp? character) (values #f 'exp)]
          [else (values #f 'fail)])]

    ['exp(cond
          [(char-numeric? character) (values #f 'exp)]
          [(par_close? character) (values 'exp 'par_close)]
          [else (values #f 'fail)])]

    ['fail (values #f 'fail)]))

    ; Import library for unit testing
(require rackunit)
; Import necesary to view the test results
(require rackunit/text-ui)

(define test-arithmetic-lexer
    (test-suite
        " Test function: arithmetic-lexer"

        ;Operations with floats, ints and variables
        (check-equal? (arithmetic-lexer "6 = 2 + 1") '(("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators with spaces")
        (check-equal? (arithmetic-lexer "97 /6 = 2 + 1") '(("97" int) ("/" op) ("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators")
        (check-equal? (arithmetic-lexer "7.4 ^3 = 2.0 * 1") '(("7.4" float) ("^" op) ("3" int) ("=" op) ("2.0" float) ("*" op) ("1" int)) "Multiple float operators with spaces")
        ;(check-equal? (arithmetic-lexer "  2 + 1") '(("2" int) ("+" op) ("1" int)) "Spaces before")
        ;(check-equal? (arithmetic-lexer "  2 + 1 ") '(("2" int) ("+" op) ("1" int)) "Spaces before and after")
        (check-equal? (arithmetic-lexer "2+1") '(("2" int) ("+" op) ("1" int)) "Binary operation ints")
        (check-equal? (arithmetic-lexer "5.2+3") '(("5.2" float) ("+" op) ("3" int)) "Float and int")
        (check-equal? (arithmetic-lexer "5.2+3.7") '(("5.2" float) ("+" op) ("3.7" float)) "Binary operation floats")
        (check-equal? (arithmetic-lexer "one+two") '(("one" var) ("+" op) ("two" var)) "Binary operation variables")
        (check-equal? (arithmetic-lexer "2 + 1") '(("2" int) ("+" op) ("1" int)) "Binary operation with spaces")
        (check-equal? (arithmetic-lexer "6 = 2 + 1") '(("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators with spaces")
        (check-equal? (arithmetic-lexer "97 /6 = 2 + 1") '(("97" int) ("/" op) ("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators")
        (check-equal? (arithmetic-lexer "7.4 ^3 = 2.0 * 1") '(("7.4" float) ("^" op) ("3" int) ("=" op) ("2.0" float) ("*" op) ("1" int)) "Multiple float operators with spaces")

        ;variables
        (check-equal? (arithmetic-lexer "data") '(("data" var)) "Single variable")
        (check-equal? (arithmetic-lexer "data34") '(("data34" var)) "Single variable")
        (check-equal? (arithmetic-lexer "34data") #f "Incorrect variable")
        
        ; Exponential
        (check-equal? (arithmetic-lexer "4e8") '(("4e8" exp)) "Exponent int")
        (check-equal? (arithmetic-lexer "4.51e8") '(("4.51e8" exp)) "Exponent float")
        (check-equal? (arithmetic-lexer "-4.51e8") '(("-4.51e8" exp)) "Negative exponent float")

        ; Comments
        ;(check-equal? (arithmetic-lexer "3// this is all") '(("3" int) ("// this is all" comment)) "Variable and comment")
        ;(check-equal? (arithmetic-lexer "3+5 // this is all") '(("3" int) ("+" op) ("5" int) ("// this is all" comment)) "Expression and comment")

        ; Parentheses
        ;(check-equal? (arithmetic-lexer "()") '(("(" par_open) (")" par_close)) "Open and close")
        ;(check-equal? (arithmetic-lexer "( )") '(("(" par_open) (")" par_close)) "Open space close")
        (check-equal? (arithmetic-lexer "(45)") '(("(" par_open) ("45" int) (")" par_close)) "Open int close")
        (check-equal? (arithmetic-lexer "( 45 )") '(("(" par_open) ("45" int) (")" par_close)) "Open space int space close")
        (check-equal? (arithmetic-lexer "(4 + 5)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close)) "Open expression close")
        (check-equal? (arithmetic-lexer "(4 + 5) * (6 - 3)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close) ("*" op) ("(" par_open) ("6" int) ("-" op) ("3" int) (")" par_close)) "Open expression close")

        
    ))

; Start the execution of the test suite
(displayln "Testing: arithmetic-lexer")
(run-tests test-arithmetic-lexer)
