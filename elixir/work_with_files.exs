# #Functions to work with files

# Miguel Bustamante
# 2022-05-03

defmodule Tfiles do

  def space_to_dash(in_filename, out_filename) do

    #Single expression of nested calls
    File.write(Enum.join(Enum.map(Enum.map(File.stream!(in_filename), &String.split/1), fn line -> Enum.join(line, "-")end),"\n"))

    #Breaking down the steps and storing the results
    temp1 = File.stream!(in_filename)
    temp2 = Enum.map(temp1, &String.split/1)
    temp3 = Enum.map(temp2, fn line -> Enum.join(line, "-")end)
    temp4 = Enum.join(temp3, "\n")
    File.write!(out_filename, temp4)

    # Using pipe operator to link the calls
    text =
      in_filename
      |> File.stream!()
      |> Enum.map(&String.split/1)
      |> IO.inspect()
      |> Enum.map(&(Enum.join(&1, "-")))
      |> IO.inspect()
      |> Enum.join("\n")

    File.write(out_filename, text)

  end

  def get_emails(in_filename, out_filename) do #Receives a file and returns a new file
    #Using pipes
    emails =
      in_filename
      |> File.stream!() #reads the file and returns a list of rows where the program has to check if there is an email
      |> Enum.map(&email_from_line/1) #makes the reference to the function email_from_line the /1 element means that the function takes 1 argument
      |> IO.inspect()
      |> Enum.filter(&(&1 != nil))
      |>Enum.map(&hd/1)
      |>Enum.join("\n")
    File.write(out_filename, emails)
  end

  def email_from_line(line) do
    #Functions that receives a line and returns the result of that regular expression
    Regex.run(~r|\w+(?:\.\w+)*@\w+(?:\.\w+)*\.[a-z]{2,4} |, line)
  end

end
