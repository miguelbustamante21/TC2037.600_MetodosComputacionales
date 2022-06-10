# Functions to work with files

# Miguel Bustamante A01781583
# Emilio Sibaja A01025139
# 2022-06-05

defmodule TextConverter do
  #Module that contains regex functions

  #Function that uses parallelism
  def paralel_json_converter(dir) do
    Path.wildcard("#{dir}/*.json")
    |> Enum.map(&Task.start(fn -> json_converter(&1, "#{&1}.html") end))
  end

  #Single function
  def single_json_converter(dir) do
    Path.wildcard("#{dir}/*.json")
    |> Enum.map(&json_converter(&1, "#{&1}.html"))
  end

  # Measures execution time of a function
  def timer(function) do
    function
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  #Function that receives one file and returns the converted text file
  def json_converter(in_filename, out_filename) do
    #reads the file
    tokens =
      in_filename
      #using pipes
      #makes the list of lines
      |> File.stream!()
      #returns all elements in the list, line by line
      |> Enum.map(&matches/1)
      # joins the result of the map
      |> Enum.join("\n")
    template1 =
      "template.html"
      |> File.stream!()
      |> IO.inspect()
      |>Enum.join("\n")
    #Returns the new html file that is created
    File.write(out_filename, [template1, tokens, "\n</pre>\n</body>\n</html>"])
  end

  #function that will make the matches when the json file is being read
  def matches(line), do: matches(String.replace(line,"\n",""),"")
  #When the line is empty return the result
  defp matches(line, res) when line == "" or line == "\n", do: res
  defp matches(line, res) do
    cond do
      #Match for punctuation
      Regex.match?(~r/(?=^) *[{},:\[\]]+/, line) -> convert_to_html(line, "punct", res)
      #Match for keys with two dots
      Regex.match?(~r/(?=^)\t* *"[\w0-9:-]+" *(?=:)/, line) -> convert_to_html(line, "key", res)
      #Match for strings
      Regex.match?(~r/(?!.*:)(?=^) *"[\(\)\;a-zA-z0-9#.&': ?@+!=\/.\*,-]*"| *"[\(\)\;a-zA-z0-9.&': ?@+!#=\/.\*,-]*"(?=[,}\]]+)|""/, line) -> convert_to_html(line, "string", res)
      #Match for numbers
      Regex.match?(~r/(?=^)(?=(?:[^"]*"[^"]*")*[^"]*\Z) *[\d+E.-]/, line) -> convert_to_html(line, "num", res)
      #Match for reserved words (true, null, false)
      Regex.match?(~r/(?!.*\d)(?=^)(?=(?:[^"]*"[^"]*")*[^"]*\Z) *[a-zA-Z]+/, line) -> convert_to_html(line, "rword", res)
      #if none of the cases match, print failure
      true -> IO.puts "Failure #{line}"
    end
  end

  def convert_to_html(line, val, res) do
    cond do
      val == "punct" ->
        [token] = Regex.run(~r/(?=^) *[{},:\[\]]+/,line)
        #Create the html
        html_value = "<span class = \"punctuation\">#{token}</span>"
        #Call the function with the converted json to html
        matches(String.replace(line, ~r/(?=^) *[{},:\[\]]+/,""),Enum.join([res,html_value]))

      val == "key" ->
        [token] = Regex.run(~r/(?=^) *\t*"[\w0-9:-]+" *(?=.*:)/,line)
        #Create the html
        html_value = "<span class = \"key\">#{token}</span>"
        #Call the function with the converted json to html
        matches(String.replace(line, ~r/(?=^) *\t*"[\w0-9:-]+" *(?=.*:)/,""),Enum.join([res,html_value]))

      val == "string" ->
        [token] = Regex.run(~r/(?!.*:)(?=^) *"[\(\)\;a-zA-z0-9#.&': ?@+!=\/.\*,-]*"| *"[\(\)\;a-zA-z0-9.&': ?@+!#=\/.\*,-]*"(?=[,}\]]+)|""/,line)
        #Create the html
        html_value = "<span class = \"string\">#{token}</span>"
        #Call the function with the converted json to html
        matches(String.replace(line, ~r/(?!.*:)(?=^) *"[\(\)\;a-zA-z0-9#.&': ?@+!=\/.\*,-]*"| *"[\(\)\;a-zA-z0-9.&': ?@+!#=\/.\*,-]*"(?=[,}\]]+)|""/,""),Enum.join([res,html_value]))

      val == "num" ->
        [token] = Regex.run(~r/(?=^)(?=(?:[^"]*"[^"]*")*[^"]*\Z) *[\d+E.-]/,line)
        #Create the html
        html_value = "<span class = \"number\">#{token}</span>"
        #Call the function with the converted json to html
        matches(String.replace(line, ~r/(?=^)(?=(?:[^"]*"[^"]*")*[^"]*\Z) *[\d+E.-]/,""),Enum.join([res,html_value]))

      val == "rword" ->
        [token] = Regex.run(~r/(?!.*\d)(?=^)(?=(?:[^"]*"[^"]*")*[^"]*\Z) *[a-zA-Z]+/,line)
        #Create the html
        html_value = "<span class = \"resword\">#{token}</span>"
        #Call the function with the converted json to html
        matches(String.replace(line, ~r/(?!.*\d)(?=^)(?=(?:[^"]*"[^"]*")*[^"]*\Z) *[a-zA-Z]+/,""),Enum.join([res,html_value]))

      true -> IO.puts "failure"

    end
  end

end

# IO.puts TextConverter.timer(fn -> TextConverter.paralel_json_converter("dir") end)
# IO.puts TextConverter.timer(fn -> TextConverter.single_json_converter("dir") end)
