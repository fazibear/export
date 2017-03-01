# Export [![Package Version](https://img.shields.io/hexpm/v/export.svg)](https://hex.pm/packages/export) [![Build Status](https://travis-ci.org/fazibear/export.svg?branch=master)](https://travis-ci.org/fazibear/export)


[Erlport](http://erlport.org/) wrapper for Elixir.

## Installation

Add export to your list of dependencies in `mix.exs`:

```elixir
def application do
  [applications: [:export]]
end

def deps do
  [
    {:export, "~> 0.1.0"},
  ]
end
```

## Usage

### Ruby

```elixir
defmodule SomeRubyCall do
  use Export.Ruby

  def call_ruby_method
    # path to ruby files
    {:ok, ruby} = Ruby.start(ruby_lib: Path.expand("lib/ruby"))

    # call "upcase" method from "test" file with "hello" argument
    ruby |> Ruby.call("test", "upcase", ["hello"])

    # same as above but prettier
    ruby |> Ruby.call(upcase("hello"), from_file: "test")
  end
end
```

### Python

```elixir
defmodule SomePythonCall do
  use Export.Python

  def call_python_method do
    # path to our python files
    {:ok, py} = Python.start(python_path: Path.expand("lib/python"))

    # call "upcase" method from "test" file with "hello" argument
    py |> Python.call("test", "upcase", ["hello"])

    # same as above but prettier
    py |> Python.call(upcase("hello"), from_file: "test")
  end
end
```
