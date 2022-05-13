# Elixir
Programs to learn Elixir

## Language references
- https://elixir-lang.org/getting-started/introduction.html
- https://joyofelixir.com/toc.html
- https://learnxinyminutes.com/docs/elixir/
- https://stackoverflow.com/questions/50496783/extract-the-second-element-of-a-tuple-in-a-pipeline
- https://subscription.packtpub.com/book/application-development/9781788472678/1/ch01lvl1sec14/functions-and-modules

### Style guide
- https://github.com/christopheradams/elixir_style_guide

## Runing examples
There are multiple ways to run Elixir programs
1. Save the files as .exs, then run with a command like:
```
elixir example.exs
```
2. Save files as .exs, then enter interactive mode with the file:
```
iex example.exs
```
then call the functions. To reload the file, use the `c` function:
```
iex> c("example.exs")
```

## Defining functions
**Lambda functions:**
```
greet = fn (name) -> IO.puts "Hello #{name}!" end
```

Capture notation, where arguments are refered to as `&n`
```
greet = &(IO.puts "Hello #{&1}!")
```

To call lambda functions, use a dot:
```
greet.("Gil")
```

**Named functions:**
Must go inside modules:
```
defmodule Multiply do
  def mult(_, 0), do: 0
  def mult(a, b), do: a + mult(a, b - 1)
end
```

Called with the module name:
```
Multiply.mult(6, 2)
```

## Tools to use Elixir
- Add ons for vim: https://bitboxer.de/2016/11/13/vim-for-elixir/
- To keep the command history in **iex**, add this line to .bashrc
```
export ERL_AFLAGS="-kernel shell_history enabled"
```
