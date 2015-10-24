defmodule Social do
  def grams, do: Grams.get
  def tweets, do: Tweets.get
  def feed, do: tweets ++ grams |> Enum.sort &(&1.epoch > &2.epoch)
end
