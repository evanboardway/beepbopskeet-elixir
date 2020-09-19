defmodule BeepbopskeetWeb.PageController do
  use BeepbopskeetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def spotify_playlists(conn, _params) do
    render(conn, "playlists.html")
  end

end
