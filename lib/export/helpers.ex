defmodule Export.Helpers do
  @moduledoc false

  def convert_options(options) do
    options
    |> Enum.map(fn opt ->
      case opt do
        {key, other_options} when other_options |> is_list ->
          {key,
           other_options
           |> Enum.map(fn {key, value} ->
             {key |> Atom.to_charlist(), value |> String.to_charlist()}
           end)}

        {key, value} when value |> is_bitstring ->
          {key, value |> String.to_charlist()}

        _ ->
          opt
      end
    end)
  end
end
