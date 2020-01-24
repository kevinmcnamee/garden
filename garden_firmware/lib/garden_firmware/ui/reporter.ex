defmodule GardenFirmware.Ui.Reporter do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    interval = opts[:interval] || 1_000
    Process.send_after(self(), :broadcast_to_ui, 10_000)
    {:ok, %{interval: interval}}
  end

  def handle_info(:broadcast_to_ui, state) do
    data = %{
      temperature: get_value("temperature"),
      humidity: get_value("humidity")
    }

    UiWeb.Endpoint.broadcast("dashboard", "readings", data)

    Process.send_after(self(), :broadcast_to_ui, state.interval)

    {:noreply, state}
  end

  defp get_value(key) do
    case GardenFirmware.Db.get(key) do
      {:ok, value} ->
        value

      {:error, :not_found} ->
        nil
    end
  end
end
