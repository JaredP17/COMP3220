#lang plai

(require racket/path)

;;creates global list variable called tokens
;;reads in every line from tokens file and saves
;;each token/lexeme pair as a separate list item
;(define tokens (file->lines (string->path "D:\\Dropbox\\auburn_faculty\\RacketPrograms\\tokens")));;school computer
;(define tokens (file->lines (string->path "F:\\Dropbox\\auburn_faculty\\RacketPrograms\\tokens")));;home computer
(define tokens (file->lines (string->path "tokens")))

;Global variable initializing number of errors to 0
(define errors 0)

;;helper function
;;retrieves the first token from the list of tokens
(define current_token
  (lambda ()
    (regexp-split #px" " (car tokens))
    );end lambda
  );end current_token

;;helper function
;;removes one token from the tokens list
;;so that current_token function always extracts
;;the next available token
(define next_token
  (lambda ()
    (set! tokens (cdr tokens))
    (cond
      ((null? tokens)
       (display "No more tokens to parse!")
       (newline)
       (display "Exiting prematurely, no eof found")
       (newline)
       (exit));end null tokens
      (else
       (cond
         ((equal? (car (current_token)) "whitespace")
          (next_token);call yourself again
          )     
         );end cond
       );end else
      );end cond
    );end lambda
  );end next_token
    

;;checks ID rule
;;if current_token is an id token
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
;;if current_token is not id, displays an error message
(define id
  (lambda ()
    (display "Entering <id>")
    (newline)
    (cond
      ((equal? (car (current_token)) "id")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (display "Leaving <id>")
       (newline)
       );end first equality check in condition
      (else
       (display "Not an id token: Error")
       (set! errors (+ errors 1))
       (newline)
       (next_token)
       );end else statement
      );end condition block
    );end lambda
  );end id

;;checks int rule
;;if current_token is an int token
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
;;if current_token is not int, displays an error message
(define int
  (lambda ()
    (display "Entering <int>")
    (newline)
    (cond
      ((equal? (car (current_token)) "int")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (display "Leaving <int>")
       (newline)
       );end first equality check in condition
      (else
       (display "Not an int token: Error")
       (set! errors (+ errors 1))
       (newline)
       (next_token)
       );end else statement
      );end condition block
    );end lambda
  );end int

;;checks factor rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define factor
  (lambda ()
    (display "Entering <factor>")
    (newline)
    (cond
      ((equal? (car (current_token)) "(")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (exp)
       (cond
         ((equal? (car (current_token)) ")")
          (display "Found ")
          (display (second (current_token)))
          (newline)
          (next_token)
          );end first equality check in nested conditon
         (else
          (display "Not a factor token: Error")
          (set! errors (+ errors 1))
          (newline)
          );end else block
         );end nested condition block
       );end first equality check in condition
      ((equal? (car (current_token)) "int")
       (int)
       );end second equality check in condition
      ((equal? (car (current_token)) "id")
       (id)
       );end third equality check in condition
      );end condition block
    (display "Leaving <factor>")
    (newline)
    );end lambda
  );end define factor
         

;;checks exp rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define exp
  (lambda ()
    (display "Entering <exp>")
    (newline)
    (term)
    (etail)
    (display "Leaving <exp>")
    (newline)
    );end lambda
  );end define exp

;;checks term rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define term
  (lambda ()
    (display "Entering <term>")
    (newline)
    (factor)
    (ttail)
    (display "Leaving <term>")
    (newline)
    );end lambda
  );end define term

;;checks etail rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define etail
  (lambda ()
    (display "Entering <etail>")
    (newline)
    (cond
      ((equal? (car (current_token)) "+")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (term)
       (etail)
       );end first equality check in condition
      ((equal? (car (current_token)) "-")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (term)
       (etail)
       );end second equality check in condition
      (else
       (display "Next token is not + or -, choosing EPSILON production")
       (newline)
       );end else block
      );end condition block
    (display "Leaving <etail>")
    (newline)
    );end lambda
  );end define etail

;;checks ttail rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define ttail
  (lambda ()
    (display "Entering <ttail>")
    (newline)
    (cond
      ((equal? (car (current_token)) "*")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (factor)
       (ttail)
       );end first equality check in condition
      ((equal? (car (current_token)) "/")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (factor)
       (ttail)
       );end second equality check in condition
      (else
       (display "Next token is not * or /, choosing EPSILON production")
       (newline)
       );end else block
      );end condition block
    (display "Leaving <ttail>")
    (newline)
    );end lambda
  );end define ttail

;;checks assign rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define assign
  (lambda ()
    (display "Entering <assign>")
    (newline)
    (id)
    (cond
      ((equal? (car (current_token)) "=")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (exp)
       );end first equality check in condition
      (else
       (display "Not an assign token: Error")
       (set! errors (+ errors 1))
       (newline)
       );end else block
      );end condition block
    (display "Leaving <assign>")
    (newline)
    );end lambda
  );end define assign

;;checks stmt rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define stmt
  (lambda ()
    (display "Entering <stmt>")
    (newline)
    (cond
      ((equal? (car (current_token)) "print")
       (display "Found ")
       (display (second (current_token)))
       (newline)
       (next_token)
       (exp)
       );end fisrt equality check in condition
      (else
       (assign)
       );end else block
      );end condition block
    (display "Leaving <stmt>")
    (newline)
    );end lambda
  );end define stmt

;;checks pgm rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define pgm
  (lambda ()
    (cond
      ((equal? (car (current_token)) "eof")
       (display "Reached end of file...")
       (newline)
       (cond
         ((equal? errors 0)
          (display "Parse successful!")
          (newline)
          );end first equality check in condition
         ((equal? errors 1)
          (display "Parse completed, but with ")
          (display errors)
          (display " error.")
          (newline)
          );end second equality check in condition
         (else
          (display "Parse completed, but with ")
          (display errors)
          (display " errors.")
          (newline)
          );end else block
         );end nested condition block
       (display "Exiting <pgm> rule")
       (newline)
       (display "Now exiting program")
       (newline)
       (exit)
       );end first equality check in condition
      (else
       (stmt)
       (pgm)
       );end else block
      );end condition block
    );end lambda
  );end define pgm

;;checks start rule
;;prints terminals along the way, calling the appropriate function
;;for non-terminals
;;displays message found + lexeme that was encountered
;;in addition, also displays when entering or leaving
;;function (parse trace)
(define start
  (lambda ()
    (display "Entering <pgm> rule")
    (newline)
    (pgm)
    );end lambda
  );end define start


;;test function to test whether or not next_token
;;will actually terminate program when it encounters
;;eof
(define tt
  (lambda ()
    (display (current_token))
    (newline)
    (next_token)
    (tt)
    )
  )