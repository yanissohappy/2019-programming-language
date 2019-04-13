(defun fib2(n)
 (if(< n 2) n (+(fib2(- n 1))(fib2(- n 2)))
 )
)
(trace fib2)

(print (fib2 3))

