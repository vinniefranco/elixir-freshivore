defmodule Grams do
  use Cacheability

  def get do
    get_cached "grams",  Gram
  end

  defp cache_and_return_items do
    Instagram.start

    grams = Instagram.user_recent_media(System.get_env("INSTAGRAM_TOKEN"))
      |> Enum.map &(Gram.build(&1))

    Cache.set_key("grams", grams)

    grams
  end
end
