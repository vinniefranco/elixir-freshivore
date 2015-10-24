defmodule Freshivore.LandingControllerTest do
  use Freshivore.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Vincent Franco"
  end
end
