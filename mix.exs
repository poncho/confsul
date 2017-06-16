defmodule Confsul.Mixfile do
  use Mix.Project

  def project do
    [app: :confsul,
     version: "0.1.2",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     description: description(),
     package: package(),
     deps: deps(),
     name: "Confsul",
     source_url: "https://github.com/ponchomf/confsul"
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:consul, "~> 1.1"},
      {:credo,                "~> 0.7.4", only: [:dev, :test]},
      {:mock,                 "~> 0.2.1", only: [:test]},
      {:excoveralls,          "~> 0.6.3", only: :test},
    ]
  end

  defp description do
    """
    Configure your Elixir apps using Consul
    """
  end

  defp package do
    [
      name: :confsul,
      files: ["lib", "mix.exs", "README*"],
      licenses: ["MIT"],
      maintainers: ["Alfonso Martínez"],
      links: %{"GitHub" => "https://github.com/ponchomf/confsul"}
    ]
  end
end
