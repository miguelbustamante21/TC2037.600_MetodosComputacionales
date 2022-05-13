# Functions with lists in Elixir
#
# Gilberto Echeverria
# 2022-04-26

defmodule Tlists do
  @moduledoc """
  Functions to work with lists
  """

  @doc """
  Sum all the numbers in a list using regular recursion
  """
  def sum_1(list) do
    if list == [] do
      0
    else
      hd(list) + sum_1(tl(list))
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
  defp do_positives([], result), do: Enum.reverse(result)
  defp do_positives([head | tail], result) when head > 0,
    do: do_positives(tail, [head | result])
  defp do_positives([_head | tail], result),
    do: do_positives(tail, result)


  @doc """
  Using default values for arguments
  This can allow users to call with invalid arguments
  """
  def positives_2(list, result \\ [])
  def positives_2([], result), do: Enum.reverse(result)
  def positives_2([head | tail], result) when head > 0,
    do: positives_2(tail, [head | result])
  def positives_2([_head | tail], result),
    do: positives_2(tail, result)


  @doc """
  Examples on the use of map
  """
  def sqrt_list(list) do
    # Provide the funtion to map as a lambda function
    Enum.map(list, fn x -> :math.sqrt(x) end)
    # Shorthand for a lambda function, using capture notation to get the args
    Enum.map(list, &(:math.sqrt(&1)))
    # Provide the reference to a function
    Enum.map(list, &:math.sqrt/1)

    # Alternative syntax: list comprehensions
    for x <- list, do: :math.sqrt(x)

  end



end
