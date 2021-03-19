defmodule BeepbopskeetWeb.Helpers.Auth do

  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!Beepbopskeet.Repo.get(Beepbopskeet.Accounts.User, user_id)
  end

  def is_admin?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id do
      Beepbopskeet.Repo.get(Beepbopskeet.Accounts.User, user_id).is_admin
    end
  end

end
