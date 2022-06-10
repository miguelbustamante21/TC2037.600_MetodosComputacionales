defmodule Tlists do
  @moduledoc """
  Functions to work with the lists
  """

  @doc """
  Sum all the numbers in a list
  """

  def sum_1(list) do
  if list == [] do
    0

  else
    hd(list) + sum_1(tl(list))
  end
  end

  @doc """
  Sum list eleents using tail recursion
  """

  def sum_2(list), do: do_sum_2(list, 0)
  defp do_sum_2([], result), do: result
  defp do_sum_2(list, result),
    do: do_sum_2(tl(list), result + hd(list))


   @doc """
  Sum list eleents using pattern matching
  """

  def sum_3(list), do: do_sum_3(list, 0)
  defp do_sum_3([], result), do: result
  defp do_sum_3([head | tail], result),
    do: do_sum_3(tail, result + head)



  @doc """
  Filter a list and keep only positive elements
  """

  def positives(list), do: positives(list, 0)
  defp positives([], result), do: result
  defp positives([head | tail], result) when head > 0,
      do: do_positives(tail, [head | result])
      defp do_positives([_head | tail], result),
      do: do_positives(tail, result)


  @doc """
  Examples on the use of map
  """
  def sqrt_list(list) do
    #Provide the function to map as a lambda function
    Enum.map(list, fn x -> :math.sqrt(x) end)
    #Shorthand for a lambda function using capture notation
    Enum.map(list, &(:math.sqrt(&1)))
    #Provide the reference to a function
    Enum.map(list, &:math.sqrt/1)

    # Alternative syntax: list comprehensions
    for x <- list, do: :math.sqrt(x)

  end



end
