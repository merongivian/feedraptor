defmodule Feedraptor.MixProject do
  use Mix.Project

  def project do
    [
      app: :feedraptor,
      version: "0.1.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:capuli, "~> 0.2.0"},
      {:timex, "~> 3.2"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib","test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
