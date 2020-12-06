defmodule Cryptrage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Cryptrage.Repo,
      # Start the Telemetry supervisor
      CryptrageWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cryptrage.PubSub},
      # Start the Endpoint (http/https)
      CryptrageWeb.Endpoint
      # Start a worker by calling: Cryptrage.Worker.start_link(arg)
      # {Cryptrage.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cryptrage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CryptrageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
