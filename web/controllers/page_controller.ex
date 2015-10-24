defmodule Freshivore.PageController do
  use Freshivore.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
