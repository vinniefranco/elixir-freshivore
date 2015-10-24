defmodule Freshivore.Cache do
  alias Exredis, as: Client
  alias Exredis.Api, as: Api

  def get(%{key: key, as: as}) do
    client = start

    client
    |> Api.get(key)
    |> decode_result(as)
    |> stop_client_and_return_result(client)
  end

  def set(key, value, ttl \\ 360) do
    client = start

    client
    |> Api.setex(key, ttl, value |> Poison.encode!)
    |> stop_client_and_return_result(client)
  end

  def purge_key(key) do
    client = start

    client
    |> Api.del(key)
    |> stop_client_and_return_result(client)
  end

  defp stop_client_and_return_result(result, client) do
    client |> Client.stop

    result
  end

  defp start do
    Client.start_using_connection_string(System.get_env("REDISTOGO_URL"))
  end

  defp decode_result(result, as) do
    case result do
      :undefined -> :empty
      json_str -> {:ok, json_str |> Poison.decode!(as: [as])}
    end
  end
end
