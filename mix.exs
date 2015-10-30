defmodule Freshivore.Mixfile do
  use Mix.Project

  def project do
    [app: :freshivore,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Freshivore, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :tzdata, :instagram],
     test_coverage: [tool: Coverex.Task]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.0.3"},
     {:phoenix_html, "~> 2.1"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"},
     {:poolboy, github: "devinus/poolboy", tag: "1.5.1"},
     {:redix, "~> 0.2.1"},
     {:instagram, "0.0.3", [github: "arthurcolle/exstagram"]},
     {:oauth, github: "tim/erlang-oauth"},
     {:extwitter, "~> 0.5"}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
  end
end
