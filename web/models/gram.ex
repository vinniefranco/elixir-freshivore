defmodule Gram do
  defstruct caption: "", image_url: "", epoch: 0, type: "gram"

  def build(raw_gram) do
    %Gram{
      epoch: String.to_integer(raw_gram["created_time"]),
      caption: captionify(raw_gram),
      image_url: image(raw_gram)
    }
  end

  def captionify(%{"caption" => raw_caption}) do
    str = raw_caption["text"] || ""

    str |> captionify
  end

  def captionify(raw_caption) do
    raw_caption
    |> String.split(" ")
    |> Enum.map(&(linkify &1))
    |> Enum.join(" ")
  end

  defp image(%{"images" => images}) do
    images["standard_resolution"]["url"]
  end

  def linkify("#" <> rest) do
    "<a href='https://instagram.com/explore/tags/" <> rest <> "'>#" <> rest <> "</a>"
  end

  def linkify("@" <> rest) do
    "<a href='https://instagram.com/" <> rest <> "'>@" <> rest <> "</a>"
  end

  def linkify(str) do
    str
  end
end
