defmodule Uro.MixProject do
  use Mix.Project

  def project do
    [
      app: :uro,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers ++ [:phoenix_swagger],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Uro.Application, []},
      extra_applications: [:logger, :runtime_tools, :email_checker]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.7"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_ecto, "~> 4.2.1"},
      {:ecto_sql, "~> 3.5.3"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.14.2 "},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:gettext, "~> 0.18.2 "},
      {:hackney, "~> 1.16"},
      {:jason, "~> 1.2.2 "},
      {:plug_cowboy, "~> 2.4.1"},
      {:comeonin, "~> 5.3.1"},
      {:bcrypt_elixir, "~> 2.2"},
      {:pow, "~> 1.0.21"},
      {:email_checker, "~> 0.1.3"},
      {:pow_assent, "~> 0.4.9"},
      {:ssl_verify_fun, "~> 1.1.6"},
      {:phoenix_swagger, "~> 0.8.2"},
      {:ex_json_schema, "~> 0.7.4"},
      {:remote_ip, "~> 0.2.1"},
      {:arc, "~> 0.11.0"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
