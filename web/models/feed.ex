defmodule Freshivore.Feed do
  alias Freshivore.Repo

  def grams(repo \\ Repo), do: repo.all Freshivore.Grams
  def tweets(repo \\ Repo), do: repo.all Freshivore.Tweets

  def feed(repo \\ Repo) do
    tweets(repo) ++ grams(repo) |> Enum.sort &(&1.epoch > &2.epoch)
  end
end
