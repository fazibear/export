defmodule Export.Mixfile do
  use Mix.Project

  def project do
    [
      app: :export,
      description: "Erlport wrapper for Elixir",
      package: package(),
      version: "0.1.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: [
        main: Export,
        source_url: "https://github.com/fazibear/export"
      ]
    ]
  end

  def package() do
    [
      maintainers: ["Michał Kalbarczyk"],
      licenses: ["MIT"],
      links: %{
        github: "https://github.com/fazibear/export"
      }
   ]
  end

  def application() do
    [
      applications: [:export]
    ]
  end

  defp deps() do
    [
      {:erlport, github: "hdima/erlport", manager: :make},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end
end
