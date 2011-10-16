:- use_module(library(lists)).

make_range(0, []).
make_range(N, [N|R]) :- succ(N1, N), make_range(N1, R).

make_var(0, []).
make_var(N, [_|R]) :- succ(N1, N), make_var(N1, R).

make_line(0, []).
make_line(N, [' '|R]) :- succ(N1, N), make_line(N1, R).

print_board(_, [], []).
print_board(Max, [Q|T], [L|B]) :- print_line(Max, Q, L), print_board(Max, T, B).

print_line(1, Pre, [_|Post], L) :- !, append(Pre, ['Q'|Post], L).
print_line(N, Pre, [E|Post], L) :- succ(N1, N), print_line(N1, [E|Pre], Post, L).
print_line(Max, Pos, L) :- make_line(Max, Post), print_line(Pos, [], Post, L).

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
    print_board(Max, Sol, Board).
    
