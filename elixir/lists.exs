# Functions with lists in Elixir
#
# Miguel Bustamante
# 2022-04-26

defmodule Tlists do

  @moduledoc """
  Functions to work with lists
  """
  @doc """
  Sum all the numbers in a list
  """
  def sum_1(list) do
    def loop(list, result) do
      if list == [] do
        0
      else
      hd(list) + sum_1(tl(list))
      end
    end
  end

  @doc """
  Sum list elements using tail recursion
  """
  def sum_2(list), do: do_sum_2(list, 0)
  # A private function that takes 2 arguments
  defp do_sum_2([], result), do: result
  defp do_sum_2(list, result),
    do: do_sum_2(tl(list), result + hd(list))

  @doc """
  Sum list elements using pattern matching
  """
  def sum_3(list), do: do_sum_3(list, 0)
  defp do_sum_3([], result), do: result
  defp do_sum_3([head | tail], result),
    do: do_sum_3(tail, result + head)

  @doc """
  Filter a list and keep only positive elements
  """
  def positives(list), do: do_positives(list, [])
  defp do_positives([], result), do: Enum.reverse(result) #if the argument is empty return result, the reverse statement is for ordering the list
  defp do_positives([head | tail], result) do #if not do the recursion
    if head > 0 do #if the first value of the list is possitive
      do_positives(tail, [head | result]) #append the value at the beggining of result
    else
      do_positives(tail, result) #if not just continue to the next value
    end
  end

end
