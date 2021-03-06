defmodule Freshivore.Socialify do
  require Logger
  def linkify(str, url_map) do
    str
    |> String.split(" ")
    |> Stream.map(&(linkify_word(&1, url_map)))
    |> Enum.join(" ")
  end

  defp linkify_word("http" <> rest, _) do
    "<a href='http#{rest}'>http#{rest}</a>"
  end

  defp linkify_word("@" <> rest, %{mention: token}) when bit_size(rest) > 0 do
    url = token |> String.replace("{@}", rest)

    "<a href='#{url}'>@#{rest}</a>"
  end

  defp linkify_word("#" <> rest, %{hash: token}) when bit_size(rest) > 0 do
    url = token |> String.replace("{@}", rest)

    "<a href='#{url}'>##{rest}</a>"
  end

  defp linkify_word(word, token) do
    word
  end
end
