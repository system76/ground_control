defmodule GroundControl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Redix, redix_config()},
      # Start the Telemetry supervisor
      GroundControlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GroundControl.PubSub},
      # Start the Endpoint (http/https)
      GroundControlWeb.Endpoint
      # Start a worker by calling: GroundControl.Worker.start_link(arg)
      # {GroundControl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GroundControl.Supervisor]

    with {:ok, pid} <- Supervisor.start_link(children, opts) do
      GroundControl.Cache.preload()

      {:ok, pid}
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GroundControlWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp redix_config, do: Application.get_env(:ground_control, :redix)
end
