-module(day2).

-export([run/0]).

-include_lib("src/defines.hrl").

run() ->
  part1(),
  part2().

part1() ->
  List = read_input("inputs/day2"),
  {HorizontalPosition, Depth} =
    lists:foldl(fun(Command, {HorizontalPosition, Depth}) ->
                   case Command of
                     <<"forward ", X/binary>> -> {HorizontalPosition + binary_to_integer(X), Depth};
                     <<"up ", Y/binary>> -> {HorizontalPosition, Depth - binary_to_integer(Y)};
                     <<"down ", Y/binary>> -> {HorizontalPosition, Depth + binary_to_integer(Y)}
                   end
                end,
                {0, 0},
                List),
  Result = HorizontalPosition * Depth,
  ?RESULT.

part2() ->
  List = read_input("inputs/day2"),
  {HorizontalPosition, Depth, _Aim} =
    lists:foldl(fun(Command, {HorizontalPosition, Depth, Aim}) ->
                   case Command of
                     <<"forward ", _X/binary>> ->
                       X = binary_to_integer(_X),
                       {HorizontalPosition + X, Depth + Aim * X, Aim};
                     <<"up ", Y/binary>> -> {HorizontalPosition, Depth, Aim - binary_to_integer(Y)};
                     <<"down ", Y/binary>> ->
                       {HorizontalPosition, Depth, Aim + binary_to_integer(Y)}
                   end
                end,
                {0, 0, 0},
                List),
  Result = HorizontalPosition * Depth,
  ?RESULT.

-spec read_input(string()) -> [binary()].
read_input(FileName) ->
  {ok, Content} = file:read_file(FileName),
  binary:split(Content, <<"\n">>, [global, trim_all]).
