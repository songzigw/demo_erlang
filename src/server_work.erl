%% @author songzigw
%% @doc @todo Add description to server_work.


-module(server_work).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/2, rpc/2, swap_code/2]).

start(Name, Mod) ->
    Pid = spawn(fun() -> loop(Name, Mod, Mod:init()) end),
    register(Name, Pid).

swap_code(Name, Mod) -> rpc(Name, {swap_code, Mod}).

rpc(Name, Request) ->
    Name ! {self(), Request},
    receive
        {Name, crash} -> exit(rpc);
        {Name, ok, Response} -> Response
    end.


%% ====================================================================
%% Internal functions
%% ====================================================================

loop(Name, Mod, OldState) ->
    receive
        {From, {swap_cod, NewCallbackMod}} ->
            From ! {Name, ok, ack},
            loop(Name, NewCallbackMod, OldState);
        {From, Request} ->
            try Mod:handle(Request, OldState) of
                {Response, NewState} ->
                    From ! {Name, ok, Response},
                    loop(Name, Mod, NewState)
            catch
                _: Why ->
                   log_the_error(Name, Request, Why),
                   From ! {Name, crash},
                   loop(Name, Mod, OldState)
            end
    end.

log_the_error(Name, Request, Why) ->
    io:format("Server ~p request ~p ~n"
              "caused exception ~p ~n",
              [Name, Request, Why]).
