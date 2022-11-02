defmodule ApiReleaseDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :api_release_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        elixir_api_release_demo: [
            applications: [api_release_demo: :permanent],
            steps: [
                :assemble
            ],
            include_erts: System.get_env("MIX_TARGET_INCLUDE_ERTS")
        ],
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ApiReleaseDemo.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.3"}
    ]
  end
end
