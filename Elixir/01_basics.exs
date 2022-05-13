# First functions in Elixir
#
# Gilberto Echeverria
# 2022-04-08

defmodule Learn do

  @doc """
  Compute the factorial of x
  """
  def fact_l(x) do
    if x == 0 do
      1
    else
      x * fact_l(x - 1)
    end
  end

  @doc """
  Another version of the factorial function
  Using PATTERN MATCHING to identify which version of the function to execute
  """
  def fact(0), do: 1
  def fact(x), do: x * fact(x - 1)

  @doc """
  Compute the factorial using tail recursion
  """
  def fact_tail(x), do: do_fact_tail(x, 1)
  # A couple of private functions. These can not be calle directly from
  # outside of the module
  defp do_fact_tail(0, a), do: a
  defp do_fact_tail(x, a), do: do_fact_tail(x - 1, x * a)

end

IO.puts Learn.fact 5
IO.puts Learn.fact_tail 35
