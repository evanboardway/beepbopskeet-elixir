defmodule BeepbopskeetWeb.PageController do
  use BeepbopskeetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def spotify_playlists(conn, _params) do
    render(conn, "playlists.html")
  end

end


#Client ID 5197bfdc2195422bb9b19099a74a87ca

#Client Secret d37cc39b17c542ceb81f7b463f43bb2c