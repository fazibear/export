defmodule Export.Python do
  import Export.Helpers

  def start(), do: :python.start()
  def start(options), do: options |> convert_options |> :python.start
  def start(name, options), do: :python.start(name, options |> convert_options)

  def start_link(), do: :python.start_link()
  def start_link(options), do: options |> convert_options |> :python.start_link
  def start_link(name, options), do: :python.start_link(name, options |> convert_options)

  def stop(instance), do: :python.stop(instance)

  def call(instance, file, function, arguments), do: :python.call(instance, String.to_atom(file), String.to_atom(function), arguments)
end
