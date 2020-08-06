defmodule LetterLinesLive.MixProject do
  use Mix.Project

  def project do
    [
      app: :letter_lines_live,
      version: "0.1.0",
      elixir: "~> 1.10.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        list_unused_filters: true
      ],
      preferred_cli_env: [
        credo: :test,
        coveralls: :test,
        "coveralls.html": :test,
        coverage_report: :test
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {LetterLinesLive.Application, []},
      extra_applications: [:logger, :runtime_tools]
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
      # Static analysis and linting
      {:credo, "~> 1.4.0", only: [:dev, :test], runtime: false},
      # Static analysis
      {:dialyxir, "~> 1.0.0-rc.7", only: :dev, runtime: false},
      # Data source much?
      {:ecto_sql, "~> 3.4"},
      # Test coverage
      {:excoveralls, "~> 0.12.3", only: :test},
      {:floki, ">= 0.0.0", only: :test},
      {:gettext, "~> 0.11"},
      # Run checks before commit and push
      {:git_hooks, "~> 0.4.1", only: :dev, runtime: false},
      {:jason, "~> 1.0"},
      # Mix app that houses base game logic and functionality. Unpublished, so using ref from GitHub
      {:letter_lines_elixir,
       github: "adam-phillips/letter_lines_elixir", ref: "20b542b9af174c84d87e68de9ed1debf10a7f71f"},
      # Continuous test running
      {:mix_test_watch, "~> 1.0.2", only: :dev, runtime: false},
      # Mocking services for tests
      {:mox, "~> 0.5", only: :test},
      {:phoenix, "~> 1.5.4"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.13.0"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      compile: "compile --warnings-as-errors",
      coverage_report: [&coverage_report/1],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "git.check": ["git_hooks.run all"],
      "hex.version_check": "run --no-start hex_version_check.exs",
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  defp coverage_report(_) do
    Mix.Task.run("coveralls.html")

    open_cmd =
      case :os.type() do
        {:win32, _} ->
          "start"

        {:unix, :darwin} ->
          "open"

        {:unix, _} ->
          "xdg-open"
      end

    System.cmd(open_cmd, ["cover/excoveralls.html"])
  end
end
