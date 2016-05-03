%% @author songzigw
%% @doc Add description to server_dynamic.


-module(server_dynamic).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0, wait/0, rpc/2]).

start() -> spawn(fun() -> wait() end).

wait() ->
    receive
        {become, F} -> F()
    end.

rpc(Pid, Q) ->
    Pid ! {self(), Q},
    receive
        {Pid, Reply} -> Reply
    end.

%% ====================================================================
%% Internal functions
%% ====================================================================


