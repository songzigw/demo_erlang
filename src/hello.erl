-module(hello).

-export([test/0]).

test()->
    List = [1,2,3,4,5,6],
    io:format("~p~n", [List]).

