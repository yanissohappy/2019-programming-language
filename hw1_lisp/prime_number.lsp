(defun prime(x)
	(cond
		((equal x 1) nil)
		((equal x 2) t)
		(t
			(loop for i from 2 to (floor(/ x 2))
				never(=(mod x i)0)
			)
		)
	)
)

(print(prime 2))
(print(prime 239))
(print(prime 999))
(print(prime 17))

