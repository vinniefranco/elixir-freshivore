defmodule Freshivore.Tweets do
  alias Freshivore.Store
  alias Freshivore.Tweet
  require Logger

  @cache_key "tweets"

  def get do
    Store.get(%{key: @cache_key, as: Tweet}) |> process_tweets
  end

  def process_tweets(:empty) do
    Logger.debug("Hard Tweet fetch")
    ExTwitter.user_timeline
    |> Enum.map(&Freshivore.Tweet.build/1)
    |> Store.set(@cache_key)
  end

  def process_tweets({:ok, tweets}) do
    tweets
  end
end
