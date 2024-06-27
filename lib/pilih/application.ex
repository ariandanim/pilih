defmodule Pilih.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PilihWeb.Telemetry,
      Pilih.Repo,
      {DNSCluster, query: Application.get_env(:pilih, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Pilih.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Pilih.Finch},
      # Start a worker by calling: Pilih.Worker.start_link(arg)
      # {Pilih.Worker, arg},
      # Start to serve requests, typically the last entry
      PilihWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pilih.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PilihWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
