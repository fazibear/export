defmodule Export.Helpers do
  @moduledoc false

  def convert_options(options) do
    options |> Enum.map(fn (opt)->
      case opt do
        {key, other_options} when is_list(other_options) ->
          {key, Enum.map(other_options, fn {key, value} ->
            {Atom.to_charlist(key), String.to_charlist(value)}
          end)}
        {key, value} when is_bitstring(value) ->
          {key, String.to_charlist(value)}
        _ -> opt
      end
    end)
  end
end
