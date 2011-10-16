my_reverse([], []).
my_reverse([H|T], R1) :- my_reverse(T, R2), append(R2, [H], R1).

my_min([X], X).
my_min([H|T], H) :- my_min(T, M), H =< M.
my_min([H|T], M) :- my_min(T, M), H > M.

my_sort([], []).
my_sort([H|T], S2) :- my_sort(T, S1), my_insert(H, S1, S2).

my_insert(H, [], [H]).
my_insert(H, [S1|S1T], [H|[S1|S1T]]) :- H =< S1.
my_insert(H, [S1|S1T], [S1|S1T2]) :- H > S1, my_insert(H, S1T, S1T2).
