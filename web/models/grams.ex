defmodule Freshivore.Grams do
  alias Freshivore.Store
  alias Freshivore.Gram
  require Logger

  @cache_key "grams"

  def get do
    Store.get(%{key: @cache_key, as: Gram}) |> process_grams
  end

  def process_grams(:empty) do
    Logger.debug("Hard Gram fetch")

    Instagram.user_recent_media(System.get_env("INSTAGRAM_TOKEN"))
    |> Enum.map(&Gram.build/1)
    |> Store.set(@cache_key)
  end

  def process_grams({:ok, grams}) do
    grams
  end
end
