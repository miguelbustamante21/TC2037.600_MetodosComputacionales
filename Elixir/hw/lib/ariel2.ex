# Miguel Bustamante A01781583
# Emilio Sibaja A01025139

defmodule Hw.Ariel2 do

  # Exercise 1
  @doc """
  The insert function receives two elements, a number "n" and a list "lst" which contains ascendant order numbers. Returns a new list with the same elements in lst but with the inserted element n in it's correct place.
  """
  def insert(lst, n), do: do_insert(lst, n, [])
  #base case, empty list, return list with the n element
  defp do_insert([], n, result) do
    if n in result do #if the n element is already in the list
      Enum.reverse(result) #just reverse the result
    else
      Enum.reverse([n | result]) #if not just add the value to the list and reverse it
    end
  end
  #if the list is not empty get the first element to the list
  defp do_insert([head | tail], n, result) do
    # Compare that element to the "n" value
      if head < n do #if head is lower than n
        do_insert(tail, n, [head | result]) #append the first element of the list
      else
        if n in result do
          do_insert(tail, n, [head | result]) #if n is already in the list continue with the next value
        else
          do_insert(tail, n, [head | [n | result]]) #append the n value
        end
      end
  end

  # Excersise 2
  @doc """
  insertion_sort takes lst.
  Sorts lst in order from small to big
  Has to use insert using insert() function
  """
  def insertion_sort(lst), do: do_insertion_sort(lst, [])
  defp do_insertion_sort([], build), do: build
  defp do_insertion_sort([head | tail], build) do
    # make the insertion and call itself
    do_insertion_sort(tail, insert(build, head))
  end

  # Excersise 3
  @doc """
  rotate_left takes n and lst
  moves lst left by n ammount
  """
  def rotate_left(lst, 0), do: lst
  def rotate_left(lst, n) do
    if n < 0 do
      do_rotate_left(n * -1, Enum.reverse(lst), true)
    else
      do_rotate_left(n, lst, false)
    end
  end
  defp do_rotate_left(n, [], reverse), do: []
  defp do_rotate_left(0, lst, reverse) do
    if reverse do
      Enum.reverse(lst)
    else
      lst
    end
  end
  defp do_rotate_left(n, [head | tail], reverse) do
    do_rotate_left(n - 1, tail ++ [head], reverse)
  end

  # def rotate_left(lst, n), do: do_rotate_left(lst, n, [])
  # #base case, if the given list is empty, return an empty list
  # defp do_rotate_left([], n, result), do: result
  # # with zero
  # defp do_rotate_left(lst, 0, result), do: lst ++ Enum.reverse(result)
  # #if n is positive
  # defp do_rotate_left([head | tail], n, result) do
  #   if n > 0 do
  #     do_rotate_left(tail, n-1, [head | result])
  #   end
  # end

  # def rotate_left(lst, n), do: do_rotate_left(lst, n,)
  # #base case, if the given list is empty, return an empty list
  # defp do_rotate_left([], n, flag), do: []
  # # with zero
  # defp do_rotate_left(lst, 0), do: lst
  # #if it's neither of this two cases
  # defp do_rotate_left(lst, n) do
  #   if flag
  # end
  #   if n < 0 do
  #     do_rotate_left(Enum.reverse(lst), n * -1, true)
  #   else
  #     do_rotate_left(lst, n, false)
  #   end
  # end


  # Excersise 10
  @doc """
  encode takes lst
  Returns the ammount of repetitions in lst [in format ((reppetitions item) (reppetitions item))]
  """

  def encode([]), do: []
  def encode(list), do: do_encode(list, nil, 0, []) # nil es null

  defp do_encode([], prev, n, build), do: Enum.reverse([{n, prev} | build])
  defp do_encode([head | tail], prev, n, build) do
    if head == prev do
      do_encode(tail, prev, n + 1, build)
    else
      if prev == nil do
        do_encode(tail, head, 1, build)
      else
        do_encode(tail, head, 1, [{n, prev} | build])
      end
    end
  end


  # Exercise 8
  @moduledoc """
  Functions to work with lists in Elixir
  """

  @doc """
  Group contiguous equal elements in a list as sublists
  """
  def pack(list), do: do_pack(list, [], [])
  #base case, empty list, return result
  defp do_pack([], temp, result),
    do: Enum.reverse(result) #reverse the result list when the "list" is empty
  #the list has only one element
  defp do_pack([head | []], temp, result), #if the next element in list is empty, add that element to result
    do: do_pack([], [], [[head | temp] | result]) #first add the element to temp and then to result to have a list of lists
  #the first two elements are equal
  defp do_pack([head, head | tail], temp, result), #if the the next element is the same as the first element add that to result
    do: do_pack([head | tail], [head | temp], result) #add that head to the temp list in order to add that list later to the list result and have a list of lists
  #the first two elements are different
  defp do_pack([head | tail], temp, result),
    do: do_pack(tail, [], [[head | temp] | result]) #if the next two elements are different add the head to the temp list in order to finish that list, then add temp to result and finally restart the temp list to add the next list of lists with different elements to result

end

