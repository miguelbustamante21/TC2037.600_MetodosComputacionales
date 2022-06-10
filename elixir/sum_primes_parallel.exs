# Functions to work with files

# Miguel Bustamante A01781583
# Emilio Sibaja A01025139
# 2022-05-17

#Primes module
defmodule Primes do

  #function that checks if the received number is prime
  def check_if_prime(n), do: do_check_if_prime(2, n)
  #the counter starts in number 2 in order to avoid ignoring the first two prime numbers (2, 3)
  defp do_check_if_prime(i, n) do
    #makes the private function to do the recursion
    cond do
      #condition to check the square root of the given number
      floor(:math.sqrt(n)) < i -> true
      #condition to check all the numbers lower than the square root
      rem(n, i) != 0 -> do_check_if_prime(i + 1, n)
      #if one of those numbers is divisible with n, means that n is not prime
      rem(n, i) == 0 -> false
    end
  end

  #function that makes the sum of prime numbers without using parallelism
  def sum_primes(1), do: 1
  def sum_primes(num), do: do_sum_primes(1, num, 0)
  # Base case
  defp do_sum_primes(n, num, res) when n == num, do: res
  defp do_sum_primes(n, num, res) do
    cond do
      #if the n value turns to be prime, makes the recursion again but adds that value to result
      check_if_prime(n) == true -> do_sum_primes(n + 1, num, res + n)
      #if the n value is not prime, makes the recursion without adding the number to the result
      check_if_prime(n) == false -> do_sum_primes(n + 1, num, res)
    end
  end

  def sum_primes_parallel(limit, threads \\ System.schedulers) do
    # Obtain amount of calculations per thread
    range = div(limit, threads)
    1..threads
    # For each element in the sequence, create a task that calls recursive function
    |> Enum.map(&Task.async(fn -> do_sum_primes(1 + range * &1 - range, range * &1, 0) end))
    # Wait for thread results
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()
  end

  # Measures execution time of a function
  def timer(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end

end

# Example
IO.puts Primes.timer(fn -> Primes.sum_primes_parallel(1000) end)
IO.puts Primes.timer(fn -> Primes.sum_primes(1000) end)
