defmodule Tweet do
  alias Timex.Parse.DateTime.Parser, as: TimeString
  alias Timex.Date, as: TimeStamp

  defstruct text: "", epoch: 0, type: "tweet"

  def build(raw_tweet) do
    %Tweet{text: text(raw_tweet.text), epoch: parse_time(raw_tweet)}
  end

  defp text(tweet) do
    tweet
    |> String.split(" ")
    |> Enum.map(&(linkify &1))
    |> Enum.join(" ")
  end

  defp linkify("#" <> rest) do
    "<a href='https://twitter.com/hashtag/" <> rest <> "/?src=hash'>#" <> rest <> "</a>"
  end

  defp linkify("@" <> rest) do
    "<a href='https://twitter.com/" <> rest <> "'>@" <> rest <> "</a>"
  end

  defp linkify(str) do
    str
  end

  defp parse_time(raw_tweet) do
    {:ok, time} = TimeString.parse(
      raw_tweet.created_at,
      "{WDshort} {Mshort} {0D} {h24}:{m}:{s} {Z} {YYYY}"
    )

    time |> TimeStamp.to_secs
  end
end
