-module(hello).
-export([test/0]).

test()->
    List = [1,2,3,4,5,6],
    Lidy = lists:filter(fun(H) ->
                                if H == 5 -> true;
                                    true  -> false
                                end
                        end, List),
    io:format("~p~n", [Lidy]).
