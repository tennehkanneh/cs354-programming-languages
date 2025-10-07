;; Duplicates a single element 'count' times
(define (duper element count)
    (if (= count 0)
        '()
        (cons element (duper element (- count 1)))))

;; Main function: super-duper
(define (super-duper source count)
  (cond
    ((not (list? source)) source)
    ((null? source) '())
    (else
     (let loop ((dups (duper (super-duper (car source) count) count))
                (rest (super-duper (cdr source) count)))
       (if (null? dups)
           rest
           (cons (car dups) (loop (cdr dups) rest)))))))


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