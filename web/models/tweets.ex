defmodule Tweets do
  use Cacheability

  def get do
    get_cached("tweets", Tweet)
  end

  defp cache_and_return_items do
    tweets = ExTwitter.user_timeline |> Enum.map &(Tweet.build(&1))

    Cache.set_key("tweets", tweets)

    tweets
  end
end
