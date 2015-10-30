defmodule Freshivore.SocialTest do
  alias Freshivore.Socialify
  use ExUnit.Case, async: true

  test "linkifies http links" do
    linked = "This http://g.ca is so linked up"
              |> Socialify.linkify(%{mention: "http://a.com/{@}"})

    assert "This <a href='http://g.ca'>http://g.ca</a> is so linked up" = linked
  end

  test "linkifies https links" do
    linked = "This https://g.ca is so linked up"
              |> Socialify.linkify(%{mention: "http://a.com/{@}"})

    assert "This <a href='https://g.ca'>https://g.ca</a> is so linked up" = linked
  end

  test "linkifies @mentions by wrapping anchor with token replaced" do
    linked = "This @guy is so linked up"
              |> Socialify.linkify(%{mention: "http://a.com/{@}"})

    assert "This <a href='http://a.com/guy'>@guy</a> is so linked up" = linked
  end

  test "does not link when mention is not provided" do
    linked = "This @guy is so linked up"
              |> Socialify.linkify(%{hash: "http://a.com/{@}"})

    assert "This @guy is so linked up" = linked
  end

  test "does not linkify single char '@' since it's not a mention" do
    linked = "@ is not linked up"
              |> Socialify.linkify(%{mention: "http://a.com/{@}"})

    assert "@ is not linked up" = linked
  end

  test "linkifies #hashtags by wrapping anchor with token replaced" do
    linked = "This #tag is so linked up"
              |> Socialify.linkify(%{hash: "http://a.com/?tags={@}"})

    assert "This <a href='http://a.com/?tags=tag'>#tag</a> is so linked up" = linked
  end

  test "does not link when hash is not provided" do
    linked = "This #tag is not linked up"
              |> Socialify.linkify(%{mention: "http://a.com/{@}"})

    assert "This #tag is not linked up" = linked
  end

  test "does not linkify single char '#' since it's not a hashtag" do
    linked = "# is not linked up"
              |> Socialify.linkify(%{hash: "http://a.com/{@}"})

    assert "# is not linked up" = linked
  end

  test "is linkifies mentions and hashs when both keys are present" do
    opts = %{hash: "so/{@}", mention: "social/{@}"}
    linked = "#hash and @mention"
              |> Socialify.linkify(opts)

    assert "<a href='so/hash'>#hash</a> and <a href='social/mention'>@mention</a>" = linked
  end
end
