defmodule ExportRubyTest do
  use ExUnit.Case
  doctest Export

  use Export.Ruby

  test "Ruby.start" do
    {:ok, pid} = Ruby.start(ruby_lib: "test")
    result = pid |> Ruby.call("test", "upcase", ["hello"])
    assert result == "HELLO"
  end

  test "Ruby.call macro" do
    {:ok, pid} = Ruby.start(ruby_lib: "test")

    result = pid |> Ruby.call(from_file: "test", invoke: upcase("hello"))
    assert result == "HELLO"
  end
end
