defmodule Confsul.Mixfile do
  use Mix.Project

  def project do
    [app: :confsul,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
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
      {:consul, "~> 1.1"}
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
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Alfonso Martínez"],
      links: %{"GitHub" => "https://github.com/ponchomf/confsul"}
    ]
  end
end
