is_prime(2).
is_prime(3).
is_prime(P) :- 
	integer(P), 
	P > 3, 
	P mod 2 =\= 0, 
	\+ has_factor(P,3).  

has_factor(N,L) :- 
	N mod L =:= 0;
	L * L < N, 
	L2 is L + 2, 
	has_factor(N,L2).
	
goldbach(X, Y) :-
	K is X - Y,
	is_prime(Y),
	is_prime(K),
	write(Y), 
	write(" "), 
	write(K), 
	nl;
	!.

loop(X, Y, K) :-
	((K = 1)->halt); 
	((K >= 2)->goldbach(X, Y),A is K - 1,B is Y + 1,loop(X, B, A)).

:-	write("Input: "),
	readln(I),
	write("Output: "), 
	nl,
	Q is div(I, 2),
	loop(I, 2, Q),
	halt.
