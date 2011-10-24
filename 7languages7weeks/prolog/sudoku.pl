chunk(_, [], []) :- !.
chunk(N, L, [LH|R]) :- take(N, L, LH, LT), chunk(N, LT, R).

take(0, L, [], L) :- !.
take(_, [], [], []).
take(N, [H|T], [H|R], O) :- N1 is N - 1, take(N1, T, R, O).


