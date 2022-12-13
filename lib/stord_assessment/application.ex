defmodule StordAssessment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      StordAssessment.Repo,
      # Start the Telemetry supervisor
      StordAssessmentWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: StordAssessment.PubSub},
      # Start the Endpoint (http/https)
      StordAssessmentWeb.Endpoint
      # Start a worker by calling: StordAssessment.Worker.start_link(arg)
      # {StordAssessment.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StordAssessment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StordAssessmentWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
