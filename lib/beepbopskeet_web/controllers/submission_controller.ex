defmodule BeepbopskeetWeb.SubmissionController do
  use BeepbopskeetWeb, :controller
  use HTTPoison.Base
  import Poison

  alias Beepbopskeet.Playlists
  alias Beepbopskeet.Playlists.Submission

  def new(conn, %{"playlist_id" => playlist_id}) do
    changeset = Playlists.change_submission(%Submission{})

    render(conn, "new.html",
      changeset: changeset,
      playlist_id: playlist_id
    )

  end

  def update(conn, %{"id" => id}) do
    sub = Playlists.get_submission!(id)
    Playlists.update_submission(sub, %{status: "ACTIVE"})

    conn
    |> put_flash(:info, "Added to active submissions.")
    |> redirect(to: Routes.page_path(conn, :admin_portal))
  end

  def create(conn, %{"submission" => submission_params, "playlist_id" => playlist_id}) do
    submission_params =
      submission_params
      |> Map.put("playlist_id", playlist_id)

    case Playlists.create_submission(submission_params) do
      {:ok, _submission} ->
        conn
        |> put_flash(:info, "Submission created successfully.")
        |> redirect(to: Routes.page_path(conn, :spotify_playlists))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, playlist_id: playlist_id)
    end
  end

  def delete(conn, %{"id" => id}) do
    submission = Playlists.get_submission!(id)
    {:ok, _submission} = Playlists.delete_submission(submission)

    conn
    |> put_flash(:info, "Submission deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :admin_portal))
  end

end
