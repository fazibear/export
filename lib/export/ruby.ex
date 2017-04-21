defmodule Export.Ruby do
  @moduledoc """
  Wrapper for ruby.

  ## Example
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
  """
  import Export.Helpers

  @doc false
  defmacro __using__(_opts) do
    quote do
      alias Export.Ruby
      require Export.Ruby
    end
  end

  @doc """
  Start Ruby instance with the default options.

  Returns `{:ok, pid}`.

  ## Examples

      iex> Export.Ruby.start()
      {:ok, pid}

  """
  def start(), do: :ruby.start()

  @doc """
  Start Ruby instance with options.
  The `options` argument should be a map with the following options.

  ## Ruby options
    - ruby: Path to the Ruby interpreter executable
    - ruby_lib: The Ruby programs search path. The Path variable can be a string in RUBYLIB format or a list of paths.

  """
  def start(options), do: options |> convert_options |> :ruby.start

  @doc """
  Start Ruby instance with name and options.
  The instance will be registered with name. The `options` argument should be a map with the following options.

  ## Ruby options
    - ruby: Path to the Ruby interpreter executable
    - ruby_lib: The Ruby programs search path. The Path variable can be a string in RUBYLIB format or a list of paths.

  """
  def start(name, options) when not is_tuple(name), do: :ruby.start({:local, name}, options |> convert_options)
  def start(name, options), do: :ruby.start(name, options |> convert_options)

  @doc """
  The same as start/0 except the link to the current process is also created.
  """
  def start_link(), do: :ruby.start_link()

  @doc """
  The same as start/1 except the link to the current process is also created.
  """
  def start_link(options), do: options |> convert_options |> :ruby.start_link

  @doc """
  The same as start/2 except the link to the current process is also created.
  """
  def start_link(name, options) when not is_tuple(name), do: :ruby.start_link({:local, name}, options |> convert_options)
  def start_link(name, options), do: :ruby.start_link(name, options |> convert_options)

  @doc """
  Stop Ruby instance
  """
  def stop(instance), do: :ruby.stop(instance)

  @doc """
  Call Ruby function.

  ## Parameters
    - instance: pid witch is returned by one of the `start` function
    - file: file to run ruby function from
    - function: name of the function
    - arguments: arguments to pass to the function

  ## Example
  ```
  # call "upcase" method from "test" file with "hello" argument
  ruby |> Ruby.call("test", "upcase", ["hello"])
  ```
  """
  def call(instance, file, function, arguments), do: :ruby.call(instance, String.to_atom(file), String.to_atom(function), arguments)

  @doc """
  Call Ruby function.

  ## Parameters
    - instance: pid witch is returned by one of the `start` function
    - expression: function expression to execute in ruby world
    - from_file: file to run ruby function from

  ## Example
  ```
  # call "upcase" method from "test" file with "hello" argument
  ruby |> Ruby.call(upcase("hello"), from_file: "test")
  ```
  """
  defmacro call(instance, expression, from_file: file) do
    {function, _meta, arguments} = expression
    arguments = arguments || []
    quote do
      :ruby.call(unquote(instance), String.to_atom(unquote(file)), unquote(function), unquote(arguments))
    end
  end
end
