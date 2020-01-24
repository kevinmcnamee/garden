defmodule GardenFirmware.Db do
  use GenServer

  @default_ets_table_name :garden_db

  def start_link(_opts \\ []) do
    ets_table_name = @default_ets_table_name
    opts = [{:ets_table_name, ets_table_name}]
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init([{:ets_table_name, ets_table_name}]) do
    :ets.new(ets_table_name, [:named_table, :set, :private])
    {:ok, %{ets_table_name: ets_table_name}}
  end

  def get(key), do: GenServer.call(__MODULE__, {:get, key})

  def reset(), do: GenServer.call(__MODULE__, :reset)

  def set({key, value}), do: set(key, value)

  def set(key, value), do: GenServer.call(__MODULE__, {:set, key, value})

  ## SERVER

  def handle_call(
        {:set, key, value},
        _from,
        %{ets_table_name: ets_table_name} = state
      ) do
    true = :ets.insert(ets_table_name, {key, value})
    {:reply, {:ok, value}, state}
  end

  def handle_call(
        {:get, key},
        _from,
        %{ets_table_name: ets_table_name} = state
      ) do
    case :ets.lookup(ets_table_name, key) do
      [{^key, value}] ->
        {:reply, {:ok, value}, state}

      _ ->
        {:reply, {:error, :not_found}, state}
    end
  end

  def handle_call(
        :reset,
        _from,
        %{ets_table_name: ets_table_name} = state
      ) do
    true = :ets.delete_all_objects(ets_table_name)
    {:reply, :ok, state}
  end
end
