hanoi(N) :- move(N, a, c, b).

move_one(P1, P3) :- format("Move from ~k to ~k", [P1, P3]), nl.

move(1, P1, P3, _) :- move_one(P1, P3).
move(N1, P1, P3, P2) :- N1 > 1, N is N1 - 1, move(N, P1, P2, P3), 
    move_one(P1, P3), move(N, P2, P3, P1).
