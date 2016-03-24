defmodule Export.Mixfile do
  use Mix.Project

  def project do
    [
      app: :export,
      description: "ICalendar parser.",
      package: package,
      version: "0.0.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def package do
    [
      maintainers: ["Michał Kalbarczyk"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/fazibear/export"}
   ]
  end

  def application do
    [
      applications: []
    ]
  end

  defp deps do
    [
    ]
  end
end
