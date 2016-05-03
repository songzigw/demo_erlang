%% @author songzigw
%% @doc Add description to server_name.


-module(server_name).

%% ====================================================================
%% API functions
%% ====================================================================
-export([init/0, add/2, all_names/0, delete/1, where/1, handle/2]).
-import(server_work, [rpc/2]).

all_names()      -> rpc(name_server, all_names).
add(Name, Place) -> rpc(name_server, {add, Name, Place}).
delete(Name)     -> rpc(name_server, {delete, Name}).
where(Name)      -> rpc(name_server, {where, Name}).

%% ====================================================================
%% Callback routines
%% ====================================================================

init() -> dict:new().

handle({add, Name, Place}, Dict) -> {ok, dict:store(Name, Place, Dict)};
handle({delete, Name}, Dict)     -> {ok, dict:erase(Name, Dict)};
handle(all_names, Dict)          -> {dict:fetch_keys(Dict), Dict};
handle({where, Name}, Dict)      -> {dict:find(Name, Dict), Dict}.

%% ====================================================================
%% Internal functions
%% ====================================================================


