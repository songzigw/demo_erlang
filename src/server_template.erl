%% @author zhangsong.

-module(server_template).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/1]).
-export([init/1]).
-export([call/2, cast/2]).

start(Mod) ->
    spawn(?MODULE, init, [Mod]).

init(Mod) ->
    register(Mod, self()),
    State = Mod:init(),
    loop(Mod, State).

call(Name, Req) ->
    Name ! {call, self(), Req},
    receive
        {Name, Res} -> Res
    end.

cast(Name, Req) ->
    Name ! {cast, Req},
    ok.


%% ====================================================================
%% Internal functions
%% ====================================================================

loop(Mod, State) ->
    receive
        {call, From, Req} ->
            {Res, State2} = Mod:handle_call(Req, State),
            From ! {Mod, Res},
            loop(Mod, State2);
        {cast, Req} ->
            State2 = Mod:handle_cast(Req, State),
            loop(Mod, State2);
        stop ->
            stop
    end.
