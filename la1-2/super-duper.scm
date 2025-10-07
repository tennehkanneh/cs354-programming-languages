;; duplicate `element` count times by consing onto `tail`
(define (duper element count tail)
  (if (= count 0)
    tail
    (cons element (duper element (- count 1) tail))))


(define (super-duper source count)
  (cond
    ;; If source is not a list, return it immediately (no duplication).
    ((not (list? source)) source)
    ;; Empty list -> empty list
    ((null? source) '())
    ;; Recursive case:
    (else
        (let ((rest-result (super-duper (cdr source) count))
            (first (car source)))
       ;; If the first element is itself a list, process it recursively
       ;; (this is the "inner" recursion). Then prepend `count` copies
       ;; of that processed element before rest-result (outer recursion).
       (duper 
            (if (list? first)
                (super-duper first count)
                first)
            count
            rest-result)))))


;; Example usage
(display (super-duper 123 1))
(display (super-duper 123 2))
(display (super-duper '() 1))
(display (super-duper '() 2))
(display (super-duper '(x) 1))
(display (super-duper '(x) 2))
(display (super-duper '(x y) 1))
(display (super-duper '(x y) 2))
(display (super-duper '((a b) y) 3))
(display "\n")