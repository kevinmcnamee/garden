defmodule GardenFirmware.Sensors do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    IO.inspect("brooooo")
    {:ok, opts}
  end
end
