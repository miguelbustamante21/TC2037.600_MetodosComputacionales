# #Functions to work with files

# Miguel Bustamante A01781583
# Emilio Sibaja A01025139
# 2022-05-17


defmodule Do_regex do

  # Functions that receives the example and then convert it to a html file
  # Receives a file and returns a new file
  def get_example(in_filename, out_filename) do
      #Using pipes
      example =
        in_filename
        # Reads the file and returns a list of rows where the program has to check if there is an email
        |> File.stream!()
        #makes the reference to the function do_regex_new_line the /1 element means that the function takes 1 , 1 row of
        |> Enum.map(&do_regex_string/1)
        #do the regex of two dots token
        |> Enum.map(&do_regex_two_dots/1)
        #do the enter regex token
        |> Enum.map(&do_regex_br/1)
        #do the regex of the square brackets token
        |> Enum.map(&do_regex_square_bracket/1)
        #do the regex of the brackets token
        |> Enum.map(&do_regex_bracket/1)
        #do the regex of the parentheses token
        |> Enum.map(&do_regex_parentheses/1)
        #do the regex of the exponential numbers token
        |> Enum.map(&do_regex_exp/1)
        #do the regex of integers token
        |> Enum.map(&do_regex_int/1)
        #do the regex of booleans and null token
        |> Enum.map(&do_regex_boolean/1)
        #do the regex of booleans and null token
        |> Enum.map(&do_regex_space/1)

        |> IO.inspect()
        # |> Enum.filter(&(&1 != nil))
        # |> Enum.map(&hd/1)
        |>Enum.join("\n")

      example2 =
        "template.html"
        |> File.stream!()

        |> IO.inspect()
        # |> Enum.filter(&(&1 != nil))
        # |> Enum.map(&hd/1)
        |>Enum.join("\n")

      #Create the new file
      File.write(out_filename, [example2, example, "\n</pre>\n</body>\n</html>"])
    end

    #Function that receives a line from the entire string and then identifies the tokens of that line
    def do_regex_br(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/\n/, line, "<br>")
    end

    def do_regex_square_bracket(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/(\[|\])/, line, "<span class=\"keys\">\\1</span>")
    end

    def do_regex_bracket(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/(\{|\})/, line, "<span class=\"keys\">\\1</span>")
    end

    def do_regex_parentheses(line) do
      #Functions that receives a line and returns the result of that regular expression
    Regex.replace(~r/(\(|\))/, line, "<span class=\"keys\">\\1</span>")
    end

    def do_regex_string(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/("(.*?)")/, line, "<span class=\"string\">\\1</span>")
    end

    def do_regex_int(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/( )([0-9]+)/, line, "<span class=\"int\">\\2</span>")
    end

    def do_regex_exp(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+))/, line, "<span class=\"exp\">\\1</span>")
    end

    def do_regex_boolean(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/(true|false|null)/, line, "<span class=\"bool\">\\1</span>")
    end

    def do_regex_two_dots(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/([;|:|,]{1,}(?![^"]*"))/, line, "<span class=\"two_dots\">\\1</span>")
    end

    def do_regex_space(line) do
      #Functions that receives a line and returns the result of that regular expression
      Regex.replace(~r/\s{2,4}/, line, "&nbsp;&nbsp;")
    end

end
