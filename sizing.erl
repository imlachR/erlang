-module(sizing).
-export([standardize_measures_to_cm/1, total_cm/1]).

% standardize_measures_to_cm(Measures) ->
%   standardize_measures_to_cm(Measures, []).

% standardize_measures_to_cm([], Acc) -> lists:reverse(Acc);
% standardize_measures_to_cm([{cm, _} = Measure | T], Acc) ->
%   standardize_measures_to_cm(T, [Measure | Acc]);
% standardize_measures_to_cm([{m, Value} | T], Acc) ->
%   standardize_measures_to_cm(T, [{cm, round(Value * 100)} | Acc]).

standardize_measures_to_cm(Measures) ->
  F = fun
      ({cm, _} = Measure) -> Measure;
      ({m, Value}) -> {cm, round(Value * 100)}
  end,
  lists:map(F, Measures).

total_cm(Measures) ->
  StandardizeMeasures = standardize_measures_to_cm(Measures),
  F = fun({cm, Value}, Acc) -> 
      Acc + Value
  end,
  lists:foldl(F, 0, StandardizeMeasures).