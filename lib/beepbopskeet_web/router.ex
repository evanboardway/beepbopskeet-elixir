defmodule BeepbopskeetWeb.Router do
  use BeepbopskeetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BeepbopskeetWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/playlists", PageController, :spotify_playlists
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeepbopskeetWeb do
  #   pipe_through :api
  # end
end
