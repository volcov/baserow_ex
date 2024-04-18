defmodule BaserowEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :baserow_ex,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      source_url: "https://github.com/volcov/baserow_ex",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}

      {:ecto, "~> 3.10"},
      {:jason, "~> 1.4"},
      {:tesla, "~> 1.4"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:mox, "~> 1.0", only: :test},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "An Elixir Library for interfacing Baserow Backend API"
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/volcov/baserow_ex"}
    ]
  end
end
