defmodule ElixirRoombot do
  @behaviour :websocket_client

  def start_link(roombot_host, channel) do
    url = "ws://#{roombot_host}/socket/websocket" |> :erlang.binary_to_list
    :websocket_client.start_link(url, __MODULE__, channel)
  end

  # Callbacks For Websocket Events
  def init(channel) do
    :timer.send_interval(1_000, :heartbeat)
    {:once, %{channel: channel}}
  end

  def onconnect(_wsreq, state) do
    IO.puts "connected!"
    send_join_request(state.channel)
    {:ok, state}
  end

 def ondisconnect(reason, state) do
    IO.puts "disconnected because #{inspect reason}"
    {:reconnect, state}
  end

  def websocket_handle({:text, msg}, _conn, state) do
    msg = Poison.decode!(msg)
    IO.puts "got a message :: #{inspect msg}"
    if msg["event"] == "phx_reply" && msg["ref"] == 1 do
      drive(state.channel, 100, 50)
    end
    {:ok, state}
  end

  def websocket_info({:send, msg}, _connstate, state) do
    msg = Poison.encode!(msg)
    IO.puts "sending: #{msg}"
    {:reply, {:text, msg}, state}
  end
  def websocket_info(:heartbeat, _connstate, state) do
    msg = %{topic: :phoenix, event: :heartbeat, ref: 3, payload: %{}}
    {:reply, {:text, Poison.encode!(msg)}, state}
  end

  def websocket_terminate(reason, _connstate, state) do
    IO.puts "Websocket closed #{inspect reason}"
    IO.inspect state
    :ok
  end

  # Private Functions
  defp drive(channel, velocity, radius) do
    send self, {
      :send, %{
        topic: channel,
        event: "drive",
        ref: 2,
        payload: %{velocity: 100, radius: 50}
      }
    }
  end

  defp send_join_request(channel) do
    msg = %{topic: channel, event: "phx_join", ref: 1, payload: %{}}
    send self, {:send, msg}
  end
end
