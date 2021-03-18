defmodule BeepbopskeetWeb.AdminController do
  use BeepbopskeetWeb, :controller
  import BeepbopskeetWeb.Helpers.Auth

  def index(conn, _params) do
    if signed_in?(conn) do
      render(conn, "admin.html")
    else
      conn
      |> put_flash(:info, "You must be authenticated to access this feature.")
      |> redirect(to: Routes.session_path(conn, :new))
    end
  end

end
