-module(gen_server_atm_sup).
-compile(export_all).
-behaviour(supervisor).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

stop() ->
    ?MODULE ! terminate.

init([]) ->
    Children = [
        {
            %id
            gen_server_atm,
            %{module, start_link, args}
            {gen_server_atm, start_link(), []},
            %Restart type
            permanent,
            %shutdown
            10000,
            %Type
            worker,
            [gen_server_atm]
        }
    ],
    {ok, {{one_for_one, 10, 10}, Children}}. %Intensity and period determines how many times does it have to die to not respawned by the supervisor!
