defmodule ExportRubyTest do
  use ExUnit.Case
  doctest Export

  alias Export.Ruby

  test "Ruby.start" do
    {:ok, pid} = Ruby.start(ruby_lib: "test")
    result = pid |> Ruby.call("test", "upcase", ["hello"])
    assert result == "HELLO"
  end
end
