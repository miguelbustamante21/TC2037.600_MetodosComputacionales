defmodule Learn
do

    def fact_l(x)
    do
        if x == 0
        do
            1
            else
                x * fact_l(x-1)
        end
    end

  """
  Same function but using matching
  """
  def fact(0), do: 1
  def fact(x), do: x * fact(x - 1)

  """
  Compute the factorial using tail recursion
  """
  def fact_tail_l(x) do
    do_fact_tail_l(x, 1)
  end
  def do_fact_tail_l(x, a) do
    if x == 0 do
      a
    else
      do_fact_tail_l(x - 1, x * a)
    end
  end

  """
  Compute the factorial using tail recursion
  """
  def fact_tail(x), do: do_fact_tail(x,1)
  defp do_fact_tail(0, a), do: a
  defp do_fact_tail(x, a), do: do_fact_tail(x - 1, x * a)

end
IO.puts(Learn.fact_l(5))
IO.puts(Learn.fact_tail_l(5))
