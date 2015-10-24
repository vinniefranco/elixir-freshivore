defmodule Freshivore.Tweets do
  alias Freshivore.Cache
  alias Freshivore.Tweet

  @cache_key "tweets"

  def get do
    Cache.get(%{key: @cache_key, as: Tweet}) |> process_tweets
  end

  def process_tweets(:empty) do
    tweets = ExTwitter.user_timeline |> Enum.map &(Freshivore.Tweet.build(&1))

    Cache.set("tweets", tweets)

    tweets
  end

  def process_tweets({:ok, tweets}) do
    tweets
  end
end
