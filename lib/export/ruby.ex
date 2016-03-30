defmodule Export.Ruby do
  import Export.Helpers
  @moduledoc """
    bla bla for ruby
  """

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
  Start Ruby instance with options. The `options` argument should be a map with the following options.

  General options:



  """
  def start(options), do: options |> convert_options |> :ruby.start
  def start(name, options), do: :ruby.start(name, options |> convert_options)

  def start_link(), do: :ruby.start_link()
  def start_link(options), do: options |> convert_options |> :ruby.start_link
  def start_link(name, options), do: :ruby.start_link(name, options |> convert_options)

  def stop(instance), do: :ruby.stop(instance)

  def call(instance, file, function, arguments), do: :ruby.call(instance, String.to_atom(file), String.to_atom(function), arguments)

  defmacro call(instance, expression, from_file: file) do
    {function, _meta, arguments} = expression

    unless arguments, do: arguments = []

    quote do
      :ruby.call(unquote(instance), String.to_atom(unquote(file)), unquote(function), unquote(arguments))
    end
  end
end
