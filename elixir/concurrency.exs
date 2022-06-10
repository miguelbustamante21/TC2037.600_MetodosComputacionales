# Basics of concurrency in Elixir
#
#

defmodule Concur do
  def welcome(name) do
    IO.puts "Hello #{name}"
  end

  def count(name, 0), do: IO.puts"#{name} Lift off!!"
  def count(name, n) do
    IO.puts "#{name}: #{n}"
    count(name, n - 1)
  end

  def sum(name, limit) do
    IO.puts "This is a thread #{name}"
    Enum.sum(1..limit) #makes the sum from 1 to the number you want
  end

  def main do
    IO.puts "MAIN THREAD START"
    # Lanch a thread, and don't wait for it to
    Task.start(fn -> welcome("Miguel") end) #task that uses an anonymun function to call the welcome function
    Task.start(fn -> welcome("Gerardo") end)
    Task.start(fn -> welcome("Tona") end)
    IO.puts "MAIN THREAD FINISH"
  end

  def rockets do
    IO.puts "MAIN THREAD START"
    ["Columbia", "Enterprise", "Atlantis", "Discoverys"]
    #Sequentially
    # |> Enum.map(&count(&1, 10))
    #Concurrency using tasks
    |> Enum.map(&Task.start(fn -> count(&1, 10) end)) #con start no tengo que hacer nada
    |> IO.inspect()
    IO.puts "MAIN THREAD FINISH"
  end

  def multi_sums(limit, threads) do
    IO.puts "MAIN THREAD START"
    1..threads
    |> Enum.map(&Task.async(fn -> sum(&1, limit) end)) #con async si puedo esperar a que terminen
    |> IO.inspect()
    |> Enum.map(&Task.await(&1)) #ya lancé los thread y cuando terminen recibir lo que ellos han calculado
    |> IO.inspect()
    |> Enum.sum()
    |> IO.inspect()
    IO.puts "MAIN THREAD FINISH"
  end

  def measure_time(function) do
  function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  # el & ampersand significa que va a capturar cada elemento de la lista para usarlo más adelante

end
