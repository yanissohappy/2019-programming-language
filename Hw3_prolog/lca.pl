my_write([First|Rest]) :-
   maplist(writeln, [First|Rest]).

ancestor(A, B) :-
	parent(A, B);
	parent(X, B),
	ancestor(A, X).

lca(A, B, Output) :-
	((A = B)->Output is A);
	((ancestor(A, B))->Output is A);
	((parent(X, A))->lca(X, B, Output)).
	
input_relation(N) :-
	N = 0;
	((N > 0)->readln([A,B]),assert(parent(A, B)),C is N - 1,input_relation(C)).

input_query(Q, List) :-
	((Q = 0)->writeln("Output:"),my_write(List));
	((Q > 0)->readln([A,B]),lca(A, B, Output),append(List, [Output], TList),C is Q - 1,input_query(C, TList)).
:-
	readln(N),
	input_relation(N - 1),
	readln(M),
	input_query(M, []),
	halt.
