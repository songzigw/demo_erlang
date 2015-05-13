-module(sweb_test).

%% -import([]).

-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

my_test() ->
    ?assert(1 + 2 =:= 3).
 
simple_test() ->
    ok = application:start(sweb),
    ?assertNot(undefined =:= whereis(sweb_sup)).

-endif.
