defmodule Cache do
  alias Exredis, as: Client
  alias Exredis.Api, as: Api

  def get_key(key, type) do
    result = Client.start |> Api.get(key)

    result |> parse_result(type)
  end

  def set_key(key, value, ttl \\ 360) do
    Client.start |> Api.setex(key, ttl, value |> Poison.encode!)
  end

  def purge_key(key) do
    Client.start |> Api.del(key)
  end

  defp parse_result(result, type) do
    case result do
      :undefined ->
        :empty
      json_str ->
        json_str |> Poison.decode! as: [type]
    end
  end
end
