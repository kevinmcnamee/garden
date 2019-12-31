defmodule GardenFirmware.Ui.Reporter do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    interval = opts[:interval] || 1_000
    broadcast_to_ui(interval)
    {:ok, %{interval: interval}}
  end

  def handle_info(:broadcast_to_ui, state) do
    broadcast_to_ui(state.interval)
    {:noreply, state}
  end

  defp broadcast_to_ui(interval) do
    UiWeb.Endpoint.broadcast("state", "reported", GardenFirmware.Dht.read())
    Process.send_after(self(), :broadcast_to_ui, interval)
  end
end
