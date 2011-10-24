% GNU Prolog compatibility definition

succ(N1, N2) :- var(N2), N1 >= 0, N2 is N1 + 1.
succ(N1, N2) :- var(N1), N2 >= 1, N1 is N2 - 1.

subtract(L, [], L).
subtract(L, [H|T], R) :- delete(L, H, R1), subtract(R1, T, R).

% Queens actual code

% make_range generate a list of numbers from N down to 1
make_range(0, []).
make_range(N, [N|R]) :- succ(N1, N), make_range(N1, R).

% make_var generate a list of N vars
make_var(N, L) :- length(L, N).

% make_line generates a list of N ' ' space characters
make_line(0, []).
make_line(N, [' '|R]) :- succ(N1, N), make_line(N1, R).

print_board(_, [], []).
print_board(Max, [Q|T], [L|B]) :- print_line(Max, Q, L), print_board(Max, T, B).

print_line(1, Pre, [_|Post], L) :- !, append(Pre, ['Q'|Post], L).
print_line(N, Pre, [E|Post], L) :- succ(N1, N), print_line(N1, [E|Pre], Post, L).
print_line(Max, Pos, L) :- make_line(Max, Post), print_line(Pos, [], Post, L).

% compute exclusion list for existing solutions
make_exclusion(_, [], []).
make_exclusion(Diff, [X|R], [U, D| RE]) :-
    U is X + Diff,
    D is X - Diff,
    succ(Diff, Diff1),
    make_exclusion(Diff1, R, RE).

valid(0, _, S, S).
valid(Pos, Range, Sol, R) :- 
    make_exclusion(1, Sol, Excl),
    subtract(Range, Excl, Poss),
    member(X, Poss),            % pick one location
    select(X, Range, Rest),     % don't reuse it
    succ(Pos1, Pos),
    valid(Pos1, Rest, [X|Sol], R).

queens(Max, Board) :- 
    make_range(Max, Range),
    make_var(Max, Sol),
    valid(Max, Range, [], Sol),
    print_board(Max, Sol, Board).
