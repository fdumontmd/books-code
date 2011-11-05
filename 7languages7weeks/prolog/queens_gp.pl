% Utility functions
succ(I1, I2) :- integer(I1), !, I1 >= 0, is(I2, I1 + 1).
succ(I1, I2) :- integer(I2), I2 > 0, is(I1, I2 - 1).

subtract(Set, [], Set).
subtract(Set, [H|T], Result) :- delete(Set, H, R1), subtract(R1, T, Result).

maplist(_, [], []).
maplist(Pred, [H|T], [X|R]) :- call(Pred, H, X), maplist(Pred, T, R).

maplistidx(_, _, [], []).
maplistidx(Pred, N, [H|T], [X|R]) :- 
    call(Pred, N, H, X), 
    succ(N, N1), 
    maplistidx(Pred, N1, T, R).

% take F is the concatenation of as many as N elements list T, and R
take(N, F, T, R) :- length(F, Fl), Tl is min(N, Fl), 
    length(T, Tl), append(T, R, F).

make_var(N, L) :- length(L, N).

const(N, _, N).
make_range(N, R) :- make_var(N, L), maplistidx(const, 1, L, R).

% n Queens, without Finite Domain library

space(_, ' ').
make_line(N, R) :- make_var(N, L), maplist(space, L, R).

format_board(Max, In, Out) :- maplist(format_line(Max), In, Out).

put_queen(Pos, Pos, _, 'Q').
put_queen(P1, P2, E, E) :- P1 \= P2.
format_line(Max, Pos, L) :- make_line(Max, R), maplistidx(put_queen(Pos), 1, R, L).

make_exclusion(_, [], []).
make_exclusion(Cur, [(X, Pos)|R], [U, D| RE]) :-
    Diff is Pos - Cur,
    U is X + Diff,
    D is X - Diff,
    make_exclusion(Cur, R, RE).

valid(0, _, _, []).
valid(Pos, Range, Sol, [X|R]) :- 
    make_exclusion(Pos, Sol, Excl),
    subtract(Range, Excl, Poss),
    member(X, Poss),           % pick one location
    select(X, Range, Rest),     % don't reuse it
    succ(Pos1, Pos),
    valid(Pos1, Rest, [(X, Pos)|Sol], R).

queens(Max, Board) :- 
    make_range(Max, Range),
    make_var(Max, Sol),
    valid(Max, Range, [], Sol),
    format_board(Max, Sol, Board).
