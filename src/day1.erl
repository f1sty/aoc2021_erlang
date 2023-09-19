-module(day1).

-import(aoc2021_erlang, [print_result/3]).

-export([part1/0, part2/0]).

part1() ->
  {ok, Content} = file:read_file("inputs/day1"),
  List =
    lists:map(fun binary_to_integer/1, binary:split(Content, <<"\n">>, [global, trim_all])),
  Result =
    lists:sum(
      lists:zipwith(fun(X, Y) ->
                       case X < Y of
                         true -> 1;
                         false -> 0
                       end
                    end,
                    List,
                    tl(List),
                    {pad, {0, 0}})),
  print_result(1, 1, Result).

part2() ->
  undefined.
