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
  undefined.

-spec read_input(string()) -> [binary()].
read_input(FileName) ->
  {ok, Content} = file:read_file(FileName),
  binary:split(Content, <<"\n">>, [global, trim_all]).
