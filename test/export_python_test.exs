defmodule ExportPythonTest do
  use ExUnit.Case
  doctest Export

  alias Export.Python

  test "Python.start" do
    {:ok, pid} = Python.start(python_path: "test")
    result = pid |> Python.call("test", "upcase", ["hello"])
    assert result == "HELLO"
  end
end
