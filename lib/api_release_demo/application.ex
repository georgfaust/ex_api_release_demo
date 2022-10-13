defmodule ApiReleaseDemo.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: ApiReleaseDemo.Router,
        options: [port: Application.get_env(:api_release_demo, :port)]
      }
    ]

    opts = [strategy: :one_for_one, name: ApiReleaseDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
