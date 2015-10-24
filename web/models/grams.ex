defmodule Freshivore.Grams do
  alias Freshivore.Cache
  alias Freshivore.Gram

  @cache_key "grams"

  def get do
    Cache.get(%{key: @cache_key, as: Gram}) |> process_grams
  end

  def process_grams(:empty) do
    grams = Instagram.user_recent_media(System.get_env("INSTAGRAM_TOKEN"))
    |> Enum.map(&(Gram.build &1))

    Cache.set("grams", grams)

    grams
  end

  def process_grams({:ok, grams}) do
    grams
  end
end
