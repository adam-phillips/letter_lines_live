defmodule LetterLinesLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LetterLinesLive.Repo,
      # Start the Telemetry supervisor
      LetterLinesLiveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LetterLinesLive.PubSub},
      # Start the Endpoint (http/https)
      LetterLinesLiveWeb.Endpoint
      # Start a worker by calling: LetterLinesLive.Worker.start_link(arg)
      # {LetterLinesLive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LetterLinesLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LetterLinesLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
