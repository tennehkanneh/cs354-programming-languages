;; Duplicates a single element 'count' times
(define (duper element count)
    (if (= count 0)
        '()
        (cons element (duper element (- count 1)))))

;; Main function: super-duper
(define (super-duper source count)
    (if (not (list? source))
        source

    )

)