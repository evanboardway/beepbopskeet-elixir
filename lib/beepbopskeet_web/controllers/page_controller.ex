defmodule BeepbopskeetWeb.PageController do
  use BeepbopskeetWeb, :controller
  import BeepbopskeetWeb.Helpers.Auth

  def index(conn, _params) do
    IO.inspect(conn)
    render(conn, "index.html")
  end

  def spotify_playlists(conn, _params) do
    render(conn, "playlists.html")
  end

  def admin_portal(conn, _params) do
    if signed_in?(conn) do
      render(conn, "admin.html")
    else
      conn
      |> put_flash(:info, "You must be authenticated to access this feature.")
      |> redirect(to: Routes.session_path(conn, :new))
    end
  end

end


#Client ID 5197bfdc2195422bb9b19099a74a87ca

#Client Secret d37cc39b17c542ceb81f7b463f43bb2c
