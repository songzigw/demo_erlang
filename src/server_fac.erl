%% @author songzigw
%% @doc @todo Add description to server_fac.


-module(server_fac).

%% ====================================================================
%% API functions
%% ====================================================================
-export([loop/0]).

loop() ->
    receive
        {From, {fac, N}} ->
            From ! {self(), fac(N)},
            io:format("self: ~p ~n", [self()]),
            loop();
        {become, Something} ->
            Something()
    end.

%% ====================================================================
%% Internal functions
%% ====================================================================

fac(0) -> 1;
fac(N) -> N * fac(N-1).
