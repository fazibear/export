defmodule Export.Python do
  import Export.Helpers
  @doc false
  defmacro __using__(_opts) do
    quote do
      alias Export.Python
      require Export.Python
    end
  end

  def start(), do: :python.start()
  def start(options), do: options |> convert_options |> :python.start
  def start(name, options), do: :python.start(name, options |> convert_options)

  def start_link(), do: :python.start_link()
  def start_link(options), do: options |> convert_options |> :python.start_link
  def start_link(name, options), do: :python.start_link(name, options |> convert_options)

  def stop(instance), do: :python.stop(instance)

  def call(instance, file, function, arguments), do: :python.call(instance, String.to_atom(file), String.to_atom(function), arguments)

  defmacro call(instance, from_file: file, invoke: expression) do
    {function, _meta, arguments} = expression
    quote do
      :python.call(unquote(instance), String.to_atom(unquote(file)), unquote(function), unquote(arguments))
    end
  end
end
