defmodule Freshivore.FeedTest do
  alias Freshivore.Feed
  use ExUnit.Case, async: true

  defmodule FakeRepo do
    def all(Freshivore.Tweets) do
      [
        %Tweet{epoch: 2},
        %Tweet{epoch: 0}
      ]
    end

    def all(Freshivore.Grams) do
      [
        %Gram{epoch: 3},
        %Gram{epoch: 1}
      ]
    end
  end

  test "aggregates Grams and Tweets by epoch ascending" do
    result = Feed.feed(FakeRepo) |> Enum.map &(&1.epoch)

    assert result = [0, 1, 2, 3]
  end
end
