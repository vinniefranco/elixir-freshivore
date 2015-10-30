defmodule Freshivore.Tweet do
  alias Timex.Parse.DateTime.Parser, as: TimeString
  alias Timex.Date, as: TimeStamp
  alias Freshivore.Socialify

  defstruct epoch: 0, id: "", text: "", type: "tweet"

  def build(raw_tweet) do
    %Freshivore.Tweet{
      epoch: raw_tweet |> parse_time,
      id:    raw_tweet.id_str,
      text:  raw_tweet.text |> text
    }
  end

  defp text(tweet) do
    social_opts = %{
      hash:    "https://twitter.com/hashtag/{@}",
      mention: "https://twitter.com/{@}"
    }

    tweet |> Socialify.linkify(social_opts)
  end

  defp parse_time(raw_tweet) do
    {:ok, time} = TimeString.parse(
      raw_tweet.created_at,
      "{WDshort} {Mshort} {0D} {h24}:{m}:{s} {Z} {YYYY}"
    )

    time |> TimeStamp.to_secs
  end
end
