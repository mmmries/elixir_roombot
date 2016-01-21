defmodule ElixirRoombot.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_roombot,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:websocket_client, "~> 1.1.0"},
      {:poison, "~> 1.5"},
    ]
  end
end
