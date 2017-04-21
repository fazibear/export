defmodule ExportPythonTest do
  use ExUnit.Case
  doctest Export

  use Export.Python

  test "Python.start" do
    {:ok, pid} = Python.start(python_path: "test")
    result = pid |> Python.call("test", "upcase", ["hello"])
    pid |> Python.stop()
    assert result == "HELLO"
  end

  test "Python.start with name" do
    {:ok, pid} = Python.start(:name, python_path: "test")
    result = pid |> Python.call("test", "upcase", ["hello"])
    pid |> Python.stop()
    assert result == "HELLO"
  end

  test "Python.start with global name" do
    {:ok, pid} = Python.start({:global, :name}, python_path: "test")
    result = pid |> Python.call("test", "upcase", ["hello"])
    pid |> Python.stop()
    assert result == "HELLO"
  end

  test "Python.call macro" do
    {:ok, pid} = Python.start(python_path: "test")
    result = pid |> Python.call(upcase("hello"), from_file: "test")
    pid |> Python.stop()
    assert result == "HELLO"
  end
end
