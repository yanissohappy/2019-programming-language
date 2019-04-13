(defun tailfib (n result y)
	(if (= n 0)
	result
	(tailfib (- n 1) y (+ result y))))
		
(defun fib (n)
	(tailfib n 0 1)
)	
	
(trace fib)
;(print (fib 8))
(fib 8)