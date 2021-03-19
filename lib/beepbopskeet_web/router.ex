defmodule BeepbopskeetWeb.Router do
  use BeepbopskeetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  if Mix.env == :dev do
    forward "/sent-emails", Bamboo.SentEmailViewerPlug
  end

  pipeline :admin do
    plug BeepbopskeetWeb.Plug.Admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BeepbopskeetWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/playlists", PageController, :spotify_playlists

    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-in", SessionController, :delete

    resources "/submissions/:playlist_id", SubmissionController, except: [:delete, :update, :index, :show, :edit]

  end

  scope "/", BeepbopskeetWeb do
    pipe_through [:browser, :admin]

    get "/admin", AdminController, :index

    resources "/cards", CardController
    resources "/announcement", AnnouncementController
    # resources "/announcement", AnnouncementController, only: [:update]


    delete "/submissions/:id", SubmissionController, :delete
    patch "/submissions/:id", SubmissionController, :update
    put "/submissions/:id", SubmissionController, :update
    resources "/users", UserController, only: [:create, :new]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BeepbopskeetWeb do
  #   pipe_through :api
  # end
end
