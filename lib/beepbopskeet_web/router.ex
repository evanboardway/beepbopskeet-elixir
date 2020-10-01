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
    get "/admin", PageController, :admin_portal

    resources "/users", UserController, only: [:create, :new]

    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-in", SessionController, :delete

    get "/submissions/new/:playlist_id/:playlist_name", SubmissionController, :new
    post "/submissions", SubmissionController, :create

    #esources "/submissions", SubmissionsController, only: [:index, :create, :delete]


  end

  # Other scopes may use custom stacks.
  # scope "/api", BeepbopskeetWeb do
  #   pipe_through :api
  # end
end
