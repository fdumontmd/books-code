-module(count).
-export([count_up_to/1]).

count_up_to(N) -> count_up_to(1, N).

count_up_to(N, N) -> [N];
count_up_to(N, M) -> [N | count_up_to(N+1, M)].