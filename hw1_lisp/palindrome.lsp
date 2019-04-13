(defvar reverse_list ())

(defun palindrome(x)
	(setq reverse_list (reverse x))
	(if(equal x reverse_list)t nil)
)

(print(palindrome '(a b c)))
(print(palindrome '(m a d a m)))
(print(palindrome '(cat dog)))
(print(palindrome '()))
(print(palindrome '(cat dog bird bird dog cat)))
