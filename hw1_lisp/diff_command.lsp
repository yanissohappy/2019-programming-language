	(defvar in1 ()) 
	(defvar in2 ())     
	(defvar list1 ()) 
	(defvar list2 ()) 
	(defvar the_same_counter ())
	(defvar nth_line1 ())
	(defvar nth_line2 ())
	(defvar nth_line3 ())
	(defvar keyline 0)
	(defvar counter1 0) ;for file1
	(defvar counter2 0) ;for file2
	(defvar x 0)
	(defvar y 0)
	(defvar end_mark 0)
	
	;(list-length '(1 3 4)) can get total atom number!!!!


	(setq in1 (open "file1.txt" :if-does-not-exist nil))
	(when in1
		(loop for line = (read-line in1 nil)
			while line
				do (push line list1)
		)
		(setq list1 (reverse list1))
		(close in1)
	)

	
	(setq in2 (open "file2.txt" :if-does-not-exist nil))
	(when in2
		(loop for line = (read-line in2 nil)
			while line
				do (push line list2)
		)
		(setq list2 (reverse list2))
		(close in2)
	)
	
	(setq the_same_counter (list-length (intersection list1 list2 :test 'equal))) ; find the same atom number
	(setq counter1 (list-length list1))
	(setq counter2 (list-length list2))
	;(print counter1)
	;(print(nth 0 list1))
	;(print(nth 1 list1))
	;(print(nth 2 list1))
	
	
(loop 
	(setq nth_line1(nth x list1))	
		(block inner
			(loop
				(setq nth_line2(nth y list2))
				(cond ((equal nth_line1 nth_line2) (loop
										(setq nth_line3(nth keyline list2)) 
										(if (and (not (equal nth_line3 nil))(not(= keyline (- counter2 1)))) (format t "~C[32m+~a~%~C[00m" #\ESC nth_line3 #\ESC))
										(if (= keyline (- counter2 1)) (format t " ~a~%" nth_line3))
										(if (= keyline (- counter2 1)) (setq end_mark(+ end_mark 1)))
										(if (= end_mark 1) (cl-user::quit))
										(setq keyline (+ 1 keyline))
										(cond ((equal keyline y) 
											(setq nth_line3(nth keyline list2))
											(setq keyline (+ 1 keyline))
											(format t " ~a~%" nth_line3)
											(return-from inner nil))
										)									
									)
					)
				)
				(if (equal y counter2) (return nil))
				(setq y (+ 1 y))
			)
		)
	(if (equal y counter2)
		(format t "~C[31m-~a~%~C[00m" #\ESC nth_line1 #\ESC)		
	)
	(setq y keyline)
	(if (equal x counter1) (return nil))
	(setq x (+ 1 x))
)	
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;以下是失敗之作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	;(defun without-last(list)
	;	(reverse (cdr (reverse list)))
	;)	
	;
	;(defun longest (a b)
	;  (if (> (list-longest a) (list-longest b)) a b))
	;
	;(defun lcs (l1 l2)
	;	(setq line_for_com1(last l1))
	;	(setq line_for_com2(last l2))
	;	
	;	(setq line_counter1(list-length l1))
	;	(setq line_counter2(list-length l2))
	;	(cond
	;		((or (null line_for_com1) (null line_for_com2)) nil)
	;		((equal line_for_com1 line_for_com2) ((print line_for_com1)
	;											(without-last l1)
	;											(without-last l2)
	;											(lcs (without-last l1) (without-last l2))
	;											))
	;		((< line_counter1 line_counter2) ((print line_for_com1)
	;											(lcs(l1 (without-last(l2))))
	;											))
	;		((> line_counter1 line_counter2) ((print line_for_com1)
	;											(lcs((without-last(l1)) l2))
	;											))												
	;		((not (equal line_for_com1 line_for_com2)) ((print line_for_com1)
	;											(without-last l1)
	;											(without-last l2)
	;											(lcs (without-last l1) (without-last l2))
	;											))			
	;		((t) (longest (lcs (without-last l1) l2) (lcs l1 (without-last l2))))
	;	)
	;
	;)
	;
	;lcs(list1 list2)