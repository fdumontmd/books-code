-module(check).
-export([check_result/1]).

check_result(success) -> "success";
check_result({error, Message}) -> lists:append("Error: ", Message).