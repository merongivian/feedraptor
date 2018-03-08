defmodule Feedraptor.MixProject do
  use Mix.Project

  def project do
    [
      app: :feedraptor,
      version: "0.1.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Feedraptor",
      source_url: "https://github.com/merongivian/feedraptor"
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
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:capuli, "~> 0.3.0"},
      {:timex, "~> 3.2"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib","test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp description do
    """
    Feed parser built in pure Elixir, Supports RSS(Feedburner/Itunes) and
    Atom(Feedburner/Youtube/Google Docs)
    """
  end

  defp package do
    [name: :feedraptor,
     files: ["lib", "mix.exs", "README*"],
     maintainers: ["Jose Añasco"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/merongivian/feedraptor"}]
  end
end
