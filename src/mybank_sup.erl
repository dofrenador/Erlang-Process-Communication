-module(mybank_sup).
-compile(export_all).


start_link() ->
    Pid = spawn(?MODULE, init, []),
    register(?MODULE, Pid).

stop() ->
    ?MODULE ! terminate.

init() ->
    process_flag(trap_exit, true),
    {ok, SupervisedPid } =  mybank_atm:start_link(),
    main_loop(SupervisedPid).

main_loop(SupervisedPid) ->
    receive
        {'EXIT', SupervisedPid, _} ->
            error_logger:error_msg("mybank_atm process died, respawning."),
            {ok, SupervisedPid1} = mybank_atm:start_link(),
            main_loop(SupervisedPid1);
        terminate ->
            mybank_atm:stop()
    end.