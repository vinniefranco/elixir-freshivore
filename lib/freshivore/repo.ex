defmodule Freshivore.Repo do
  def all(Freshivore.Grams) do
    Freshivore.Grams.get
  end

  def all(Freshivore.Tweets) do
    Freshivore.Tweets.get
  end

  def all(_module) do
    []
  end
end
