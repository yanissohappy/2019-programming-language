my_write([First|Rest]) :-
   maplist(writeln, [First|Rest]).

all_relation(A,C,List):-
	has_relation(A,C),has_relation(C,A);
	has_relation(A,X),
	has_relation(X,A),
	(\+(member(X, List))),
	append(List, [A], TList),
	all_relation(X, C, TList). 
 
reachable(A, B, Output) :-
  	(all_relation(A, B, [])->(Output = "Yes"));
	(\+all_relation(A, B, [])->(Output = "No")).

input_relation(N) :-
	N = 0;
	((N > 0)->readln([A,B]),assert(has_relation(A, B)),assert(has_relation(B, A)),T is N - 1,input_relation(T)).

input_query(Q, List) :-
	((Q = 0)->writeln("Output:"),my_write(List));
	((Q > 0)->readln([A,B]),reachable(A, B, Output),append(List, [Output], TList),T is Q - 1,input_query(T, TList)).

:-
	readln([N,E]),
	integer(N),
	input_relation(E),
	readln(I),
	input_query(I, []),
	halt.
