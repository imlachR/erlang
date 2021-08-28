-module(mybank).

-export([start/0, stop/0]).
-export([deposit/2]).
-export([init/0]).

% ========== API ==========
start() ->
  io:format("----> Opening bank ~n"),
  Pid = spawn(?MODULE, init, []),
  register(?MODULE, Pid).

stop() ->
  ?MODULE ! terminate.

deposit(AccountId, Amount) ->
  ?MODULE ! {deposit, self(), AccountId, Amount},
  receive
    Reply -> Reply 
  after 5000 ->
    {error, timeout}
  end.

balance(AccountId) ->
  ?MODULE ! {balance, self(), AccountId},
  receive
    Reply -> Reply
  after 5000 ->
    {error, timeout}
  end.

% ========== Internal ==========
init() ->
  Accounts = dict:new(),
  main_loop(Accounts).

main_loop(Accounts) ->
  receive
    {deposit, CallerPid, AccountId, Amount} ->
      CurrentBalance = get_current_balance(AccountId, Accounts),
      Accounts1 = dict:store(
          AccountId,
          CurrentBalance + Amount,
          Accounts
        ),
        CallerPid ! ok,
        main_loop(Accounts1);
    {balance, CallerPid, AccountId} ->
      CallerPid ! {ok, get_current_balance(AccountId, Accounts)},
      main_loop(Accounts);
    terminate ->
      io:format("----> Closing bank.~n")
  end.

get_current_balance(AccountId, Accounts) ->
  case dict:find(AccountId, Accounts) of
    error -> 0;
    {ok, amount0} -> Amount0
  end