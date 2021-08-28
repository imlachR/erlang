-module(legible).
-export([starts_with/2]).

% starts_with([], _) -> true;
% starts_with([H|TPortion], [H|TString]) ->
%   starts_with(TPortion, TString);
% starts_with(_, _) -> false.

% starts_with(Portion, String) ->
%   case string:left(String, length(Portion)) of
%     Portion -> true;
%     _ -> false
%   end.

starts_with(Portion, String) ->
  Left = string:left(String, length(Portion)),
  if 
    Left =:= Portion -> true;
    true -> false
  end.