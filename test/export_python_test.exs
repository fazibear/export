defmodule ExportPythonTest do
  use ExUnit.Case
  doctest Export

  use Export.Python

  test "Python.start" do
    {:ok, pid} = Python.start(python_path: "test")
    result = pid |> Python.call("test", "upcase", ["hello"])
    assert result == "HELLO"
  end

  test "Python.call macro" do
    {:ok, pid} = Python.start(python_path: "test")

    result = pid |> Python.call(from_file: "test", invoke: upcase("hello"))
    assert result == "HELLO"
  end
end
