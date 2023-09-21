-module(aoc2021_erlang).

-export([run_all/0, print_result/3]).

-spec print_result(pos_integer(), pos_integer(), any()) -> ok.
print_result(Day, Part, Result) ->
  io:format("[~p] ~p: ~p~n", [Day, Part, Result]).

run_all() ->
  day1:run(),
  day2:run(),
  day3:run().
