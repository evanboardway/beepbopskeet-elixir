defmodule BeepbopskeetWeb.Plug.Admin do
  @behaviour Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)

    IO.inspect(user_id)
    case user_id do
      nil ->
        conn
        |> put_flash(:info, "You need to sign in before you can do that")
        |> redirect(to: "/sign-in")
        |> halt()

      _ ->
        user = Beepbopskeet.Repo.get(Beepbopskeet.Accounts.User, user_id)

        case user.is_admin do
          false ->
            conn
            |> put_flash(:info, "You must be an admin to go here")
            |> redirect(to: "/")
            |> halt()

          true ->
            conn
        end
    end
  end
end
