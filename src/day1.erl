-module(day1).

-import(aoc2021_erlang, [print_result/3]).

-export([run/0]).

-define(RESULT, print_result(?MODULE, ?FUNCTION_NAME, Result)).

run() ->
  part1(),
  part2().

part1() ->
  List = read_input("inputs/day1"),
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
  ?RESULT.

part2() ->
  List = read_input("inputs/day1"),
  ChunkedList = lists:map(fun lists:sum/1, chunk(List, 3, [])),
  Result =
    lists:sum(
      lists:zipwith(fun(X, Y) ->
                       case X < Y of
                         true -> 1;
                         false -> 0
                       end
                    end,
                    ChunkedList,
                    tl(ChunkedList),
                    {pad, {0, 0}})),
  ?RESULT.

-spec read_input(string()) -> [integer()].
read_input(FileName) ->
  {ok, Content} = file:read_file(FileName),
  lists:map(fun binary_to_integer/1, binary:split(Content, <<"\n">>, [global, trim_all])).

-spec chunk(list(), pos_integer(), list()) -> list().
chunk(List, ChunkSize, ChunkedList) ->
  {Chunk, Tail} = lists:split(ChunkSize, List),
  if Tail =:= [] ->
       lists:reverse([Chunk | ChunkedList]);
     true ->
       chunk(tl(Chunk) ++ Tail, ChunkSize, [Chunk | ChunkedList])
  end.
