defmodule Freshivore.Router do
  use Freshivore.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Freshivore do
    pipe_through :browser # Use the default browser stack

    get "/", LandingController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Freshivore do
  #   pipe_through :api
  # end
end
