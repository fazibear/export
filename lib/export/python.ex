defmodule Export.Python do
  @moduledoc """
  Wrapper for ruby.

  ## Example
  ```elixir
  defmodule SomePythonCall do
    use Export.Python

    def call_python_method
      # path to our python files
      {:ok, py} = Python.start(python_path: Path.expand("lib/python"))

      # call "upcase" method from "test" file with "hello" argument
      py |> Python.call("test", "upcase", ["hello"])

      # same as above but prettier
      py |> Python.call(upcase("hello"), from_file: "test")
    end
  end
  ```
  """
  import Export.Helpers

  @doc false
  defmacro __using__(_opts) do
    quote do
      alias Export.Python
      require Export.Python
    end
  end

  @doc """
  Start Python instance with the default options.

  Returns `{:ok, pid}`.

  ## Examples

      iex> Export.Python.start()
      {:ok, pid}

  """
  def start(), do: :python.start()

  @doc """
  Start Python instance with options.
  The instance will be registered with name. The `options` argument should be a map with the following options.

  ## Python options
    - python: Path to the Python interpreter executable
    - python_path: The Python modules search path. The Path variable can be a string in PYTHONPATH format or a list of paths.
  """
  def start(options), do: options |> convert_options |> :python.start

  @doc """
  Start Python instance with name and options.
  The instance will be registered with name. The `options` argument should be a map with the following options.

  ## Python options
    - python: Path to the Python interpreter executable
    - python_path: The Python modules search path. The Path variable can be a string in PYTHONPATH format or a list of paths.
  """
  def start(name, options) when not is_tuple(name), do: :python.start({:local, name}, options |> convert_options)
  def start(name, options), do: :python.start(name, options |> convert_options)

  @doc """
  The same as start/0 except the link to the current process is also created.
  """
  def start_link(), do: :python.start_link()

  @doc """
  The same as start/1 except the link to the current process is also created.
  """
  def start_link(options), do: options |> convert_options |> :python.start_link

  @doc """
  The same as start/2 except the link to the current process is also created.
  """
  def start_link(name, options) when not is_tuple(name), do: :python.start_link({:local, name}, options |> convert_options)
  def start_link(name, options), do: :python.start_link(name, options |> convert_options)

  @doc """
  Stop Python instance
  """
  def stop(instance), do: :python.stop(instance)

  @doc """
  Call Python function.

  ## Parameters
    - instance: pid witch is returned by one of the `start` function
    - file: file to run ruby function from
    - function: name of the function
    - arguments: arguments to pass to the function

  ## Example
  ```
  # call "upcase" method from "test" file with "hello" argument
  py |> Python.call("test", "upcase", ["hello"])
  ```
  """
  def call(instance, file, function, arguments), do: :python.call(instance, String.to_atom(file), String.to_atom(function), arguments)

  @doc """
  Call Python function.

  ## Parameters
    - instance: pid witch is returned by one of the `start` function
    - expression: function expression to execute in ruby world
    - from_file: file to run ruby function from

  ## Example
  ```
  # call "upcase" method from "test" file with "hello" argument
  py |> Python.call(upcase("hello"), from_file: "test")
  ```
  """
  defmacro call(instance, expression, from_file: file) do
    {function, _meta, arguments} = expression
    arguments = arguments || []
    quote do
      :python.call(unquote(instance), String.to_atom(unquote(file)), unquote(function), unquote(arguments))
    end
  end
end
