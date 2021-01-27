-module(mybank).
-compile(export_all).

start() ->
    mybank_sup:start().
stop() ->
    mybank_sup:stop().

deposit(AccountId,Amount) ->
    mybank_atm:deposit(AccountId,Amount).

withdraw(AccountId,Amount) ->
    mybank_atm:withdraw(AccountId,Amount).

balance(AccountId) ->
    mybank_atm:balance(AccountId).