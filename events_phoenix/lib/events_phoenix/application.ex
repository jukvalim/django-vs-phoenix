defmodule EventsPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      EventsPhoenix.Repo,
      # Start the Telemetry supervisor
      EventsPhoenixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EventsPhoenix.PubSub},
      # Start the Endpoint (http/https)
      EventsPhoenixWeb.Endpoint
      # Start a worker by calling: EventsPhoenix.Worker.start_link(arg)
      # {EventsPhoenix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventsPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EventsPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
