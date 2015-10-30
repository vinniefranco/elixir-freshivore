defmodule Freshivore.Store do
  use GenServer
  require Logger

  @ten_minutes 600

  @doc """
  Starts a cache server
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Gets a `key` and decodes the resulting list as given `as`
  """
  def get(%{key: key, as: as}) do
    GenServer.call(__MODULE__, {:get, {key, as}})
  end

  @doc """
  Sets a `value` in a cache `key` for quicker retrieval
  """
  def set(value, key) do
    GenServer.cast(__MODULE__, {:set, {value, key}})

    value
  end

  @doc """
  Purges a `key` from redis
  """
  def purge(key) do
    GenServer.call(__MODULE__, {:purge, key})
  end

  def init(:ok) do
    Logger.debug "Starting Store"

    {:ok, []}
  end

  def handle_call({:get, {key, as}}, _from, state) do
    result = Freshivore.RedixPool.command(["GET", key]) |> decode_result(as)

    {:reply, result, state}
  end

  def handle_call({:purge, key}, _from, state) do
    result = Freshivore.RedixPool.command(["DEL", key])

    {:reply, result, state}
  end

  def handle_cast({:set, {value, key}}, state) do
    Freshivore.RedixPool.command([
      "SETEX", key, @ten_minutes, value |> Poison.encode!
    ])

    {:noreply, state}
  end

  def handle_cast(request, state) do
    super(request, state)
  end

  def terminate(reason, state) do
    Logger.debug "Stopping Store"

    :ok
  end

  defp decode_result(result, as) do
    case result do
      {:ok, nil}      -> :empty
      {:ok, json_str} -> {:ok, json_str |> Poison.decode!(as: [as])}
    end
  end
end
