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
    {:ok, pid} = Ruby.start(ruby_lib: Path.expand("lib/ruby"))

    # call "upcase" method from "test" file with "hello" argument
    pid |> Ruby.call("test", "upcase", ["hello"])

    # same as above but prettier
    pid |> Ruby.call(upcase("hello"), from_file: "test")

    #flush the pid
    Ruby.stop(pid)
  end
end
```

### Python

```elixir
defmodule SomePythonCall do
  use Export.Python

  def call_python_method do
    # path to our python files
    {:ok, pid} = Python.start(python_path: Path.expand("lib/python"))

    # call "upcase" method from "test" file with "hello" argument
    pid |> Python.call("test", "upcase", ["hello"])

    # same as above but prettier
    pid |> Python.call(upcase("hello"), from_file: "test")

    #flush the pid
    Python.stop(pid)
  end
end
```

## Thank you!

[![Become Patreon](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/bePatron?u=6912974)
