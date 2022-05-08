defmodule Argentaria.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Argentaria.Repo,
      # Start the Telemetry supervisor
      ArgentariaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Argentaria.PubSub},
      # Start the Endpoint (http/https)
      ArgentariaWeb.Endpoint
      # Start a worker by calling: Argentaria.Worker.start_link(arg)
      # {Argentaria.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Argentaria.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArgentariaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
