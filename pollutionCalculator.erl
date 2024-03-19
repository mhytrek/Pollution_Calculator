%%%-------------------------------------------------------------------
%%% @author michalinahytrek
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. mar 2024 16:28
%%%-------------------------------------------------------------------
-module(pollutionCalculator).
-author("michalinahytrek").

%% API
-export([testy/0]).
-export([number_of_readings/2]).

-export([look_for_max_type/2]).
-export([calculate_max/2]).

-export([look_for_mean_type/2]).
-export([create_table/2]).
-export([sum_table/1]).
-export([calculate_mean/2]).

testy() ->
  A1 = {"Cracow", {{10,12,2023}, {10,34,22}}, [{pm10, 9}, {pm1,5}]},
  A2 = {"Wienn", {{20,12,2023}, {11,20,40}}, [{pm10, 8}, {pm1,4}, {temp, -3}]},
  A3 = {"Paris", {{11,12,2023}, {6,56,11}}, [{pm1,7}]},
  A4 = {"Madrid", {{1,1,2024}, {07,30,12}}, [{pm10,10}, {temp, 5}, {wind, 10}]},
  A5 = {"Cracow", {{12,12,2023}, {10,34,22}}, [{pm10, 8}, {pm1,10}]},
  A6 = {"Praha", {{12,12,2023}, {10,34,22}}, [{pm10, 5}, {pm1,7}, {temp, 2}, {wind,15}]},
  [A1, A2, A3, A4, A5, A6].

% number of readings

number_of_readings([{_,{Date, _},_}|T], Date) -> 1 + number_of_readings(T, Date);
number_of_readings([_|T], Date) ->  number_of_readings(T, Date);
number_of_readings([], _) -> 0.


% calculate max

look_for_max_type([{Type, Var}| T], Type) -> max(Var, look_for_max_type(T, Type));
look_for_max_type([_| T], Type) -> look_for_max_type(T, Type);
look_for_max_type([], _) -> -1000.
calculate_max([{_,_,L} | T], Type) -> max(look_for_max_type(L, Type), calculate_max(T, Type));
calculate_max([], _) -> -1000.


% calculate mean

look_for_mean_type([{Type, Var}| T], Type) -> [ Var | look_for_mean_type(T, Type)];
look_for_mean_type([_| T], Type) -> look_for_mean_type(T, Type);
look_for_mean_type([], _) -> [].
create_table([{_,_,L} | T], Type) -> look_for_mean_type(L, Type) ++ create_table(T, Type);
create_table([], _) -> [].
sum_table([H|T]) -> H + sum_table(T);
sum_table([]) -> 0.
calculate_mean(Readings, Type) ->
  A = create_table(Readings, Type),
  sum_table(A) / length(A).

