defmodule ExportRubyTest do
  use ExUnit.Case
  doctest Export

  use Export.Ruby

  test "Ruby.start" do
    {:ok, pid} = Ruby.start(ruby_lib: "test")
    result = pid |> Ruby.call("test", "upcase", ["hello"])
    pid |> Ruby.stop()
    assert result == "HELLO"
  end

  test "Ruby.start with name" do
    {:ok, pid} = Ruby.start(:name, ruby_lib: "test")
    result = pid |> Ruby.call("test", "upcase", ["hello"])
    pid |> Ruby.stop()
    assert result == "HELLO"
  end

  test "Ruby.start with global name" do
    {:ok, pid} = Ruby.start({:global, :name}, ruby_lib: "test")
    result = pid |> Ruby.call("test", "upcase", ["hello"])
    pid |> Ruby.stop()
    assert result == "HELLO"
  end

  test "Ruby.call macro" do
    {:ok, pid} = Ruby.start(ruby_lib: "test")
    result = pid |> Ruby.call(upcase("hello"), from_file: "test")
    pid |> Ruby.stop()
    assert result == "HELLO"
  end
end
