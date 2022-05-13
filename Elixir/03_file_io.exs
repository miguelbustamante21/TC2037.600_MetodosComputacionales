# Functions to work with files
#
# Gilberto Echeverria
# 2022-05-03

defmodule Tfiles do

  def space_to_dash(in_filename, out_filename) do
    # Single expression of nested calls
    File.write(out_filename, Enum.join(Enum.map(Enum.map(File.stream!(in_filename),
      &String.split/1), fn line -> Enum.join(line, "-") end), "\n"))

    # Breaking down the steps and storing the results
    temp1 = File.stream!(in_filename)
    temp2 = Enum.map(temp1, &String.split/1)
    temp3 = Enum.map(temp2, fn line -> Enum.join(line, "-") end)
    temp4 = Enum.join(temp3, "\n")
    File.write(out_filename, temp4)

    # Using pipe operator to link the calls
    text =
      in_filename
      |> File.stream!()
      |> Enum.map(&String.split/1)
      #|> IO.inspect()
      |> Enum.map(&(Enum.join(&1, "-")))
      #|> IO.inspect()
      |> Enum.join("\n")
    File.write(out_filename, text)
  end

  def get_emails(in_filename, out_filename) do
    emails =
      in_filename
      |> File.stream!()
      |> Enum.map(&email_from_line/1)
      #|> IO.inspect()
      |> Enum.filter(&(&1 != nil))
      |> Enum.map(&hd/1)
      |> Enum.join("\n")
    File.write(out_filename, emails)
  end

  def email_from_line(line) do
    Regex.run(~r|\w+(?:\.\w+)*@\w+(?:\.\w+)*\.[a-z]{2,4}|, line)
  end

end
