-module(day3).

-export([run/0]).

-include_lib("src/defines.hrl").

run() ->
  part1(),
  part2().

part1() ->
  List = read_input("inputs/day3"),
  BitLength = length(lists:nth(1, List)),
  Threshold = length(List) div 2,
  Counts =
    lists:foldl(fun(Digits, Acc) ->
                   DigitsUpdate = [Digit - $0 || Digit <- Digits],
                   lists:zipwith(fun(A, B) -> A + B end, Acc, DigitsUpdate)
                end,
                lists:duplicate(BitLength, 0),
                List),
  GammaRate =
    list_to_integer(lists:map(fun(Digit) ->
                                 if Digit > Threshold -> $1;
                                    true -> $0
                                 end
                              end,
                              Counts),
                    2),
  EpsilonRate =
    list_to_integer(lists:map(fun(Digit) ->
                                 if Digit > Threshold -> $0;
                                    true -> $1
                                 end
                              end,
                              Counts),
                    2),
  Result = GammaRate * EpsilonRate,
  ?RESULT.

part2() ->
  undefined.

-spec read_input(string()) -> [string()].
read_input(FileName) ->
  {ok, Content} = file:read_file(FileName),
  lists:map(fun binary_to_list/1, binary:split(Content, <<"\n">>, [global, trim_all])).
