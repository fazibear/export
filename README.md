# Export ![Package Version](https://img.shields.io/hexpm/v/export.svg) [![Build Status](https://travis-ci.org/fazibear/export.svg?branch=master)](https://travis-ci.org/fazibear/export)

Erlang erlport wrapper for elixir.

## Installation

Add export to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:export, "~> 0.0.1"}]
end
```

## Usage

### Ruby

```elixir
defmodule SomeRubyCall do
  alias Export.Ruby

  def call_ruby_method
    # path to ruby files
    {:ok, ruby} = Ruby.start(ruby_lib: Path.expand("lib/ruby"))

    # call "upcase" method from "test" file
    ruby |> Ruby.call("test", "upcase", [])
  end
end
```

### Python

```elixir
defmodule SomeRubyCall do
  alias Export.Python

  def call_ruby_method
    # path to our python files
    {:ok, py} = Python.start(python_path: Path.expand("lib/python"))

    # call "upcase" method from "test" file
    py |> Python.call("test", "upcase", [])
  end
end
```
