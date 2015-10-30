defmodule Freshivore.Gram do
  alias Freshivore.Socialify

  defstruct epoch: 0, image_url: "", link: "", type: "gram", caption: ""

  def build(raw_gram) do
    %Freshivore.Gram{
      caption: captionify(raw_gram),
      epoch: String.to_integer(raw_gram["created_time"]),
      image_url: get_in(raw_gram, ["images", "low_resolution", "url"]),
      link: raw_gram["link"]
    }
  end

  def captionify(%{"caption" => raw_caption}) do
    social_opts = %{
      hash: "https://instagram.com/explore/tags/{@}",
      mention: "https://instagram.com/{@}"
    }

    (raw_caption["text"] || "") |> Socialify.linkify(social_opts)
  end
end
