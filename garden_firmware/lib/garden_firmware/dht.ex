defmodule GardenFirmware.Dht do
  use GenServer

  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    interval = 5_000
    schedule(interval)

    {:ok, %{data: %{temperature: 0, humidity: 0}, interval: interval}}
  end

  defp schedule(interval) do
    Process.send_after(self(), :poll_for_readings, interval)
  end

  def handle_info(:poll_for_readings, state) do
    schedule(state.interval)

    celcius = 22.0

    humidity = 42.7

    farenheit = celcius * 9 / 5 + 32

    GardenFirmware.Db.set("temperature", farenheit)
    GardenFirmware.Db.set("humidity", humidity)

    {:noreply, state}
  end
end
