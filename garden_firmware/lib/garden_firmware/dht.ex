defmodule GardenFirmware.Dht do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def read() do
    GenServer.call(__MODULE__, :read)
  end

  def init(opts) do
    schedule(5_000)

    {:ok, [data: %{temperature: nil, humidity: nil}, interval: 5_000]}
  end

  defp schedule(interval) do
    Process.send_after(self(), :poll_for_readings, interval)
  end

  def handle_call(:read, _from, state) do
    {:reply, {:ok, state.data}, state}
  end

  def handle_info(:poll_for_readings, state) do
    case NervesDHT.read(:dht11, 17) do
      {:ok, humidity, temperature} ->
        schedule(state.interval)

        {:noreply, %{state | temperature: temperature, humidity: humidity}}

      error ->
        schedule(state.interval)

        {:noreply, state}
    end
  end
end
