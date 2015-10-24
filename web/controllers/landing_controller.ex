defmodule Freshivore.LandingController do
  use Freshivore.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", feed: Social.feed
  end
end
