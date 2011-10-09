-module(yet_again).
-export([another_factorial/1]).
-export([another_fib/1]).
-export([tr_fact/1]).

another_factorial(0) -> 1;
another_factorial(N) -> N * another_factorial(N-1).

tr_fact(N) -> tr_fact(N, 1).
tr_fact(0, A) -> A;
tr_fact(N, A) -> tr_fact(N-1, N*A).

another_fib(0) -> 1;
another_fib(1) -> 1;
another_fib(N) -> another_fib(N-1) + another_fib(N-2).
