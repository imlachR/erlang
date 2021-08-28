-module(guards).
-export([demo/1]).
-export([is_domestic/1]).
-define(DOMESTIC_ANIMALS, [cat, dog, lion, donkey]).

demo(X) when (is_integer(X) orelse is_float(X)) andalso X < 5 ->
  small_number;
demo(X) when is_integer(X); is_float(X) ->
  bigger_number;
demo(X) when is_list(X), length(X) < 5 ->
  short_list;
demo(X) when is_list(X) ->
  list.

% is_domestic(Animal) when Animal =:= cat; Animal =:= dog ->
%   true;
% is_domestic(_) -> false.

is_domestic(Animal) ->
  lists:member(Animal, ?DOMESTIC_ANIMALS).