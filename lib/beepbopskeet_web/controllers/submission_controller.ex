defmodule BeepbopskeetWeb.SubmissionController do
  use BeepbopskeetWeb, :controller
  use HTTPoison.Base

  import Poison
  import BeepbopskeetWeb.Helpers.Spotify

  alias Beepbopskeet.Playlists
  alias Beepbopskeet.Playlists.Submission
  alias Beepbopskeet.Mailer
  alias BeepbopskeetWeb.Email

  def new(conn, %{"playlist_id" => playlist_id}) do
    changeset = Playlists.change_submission(%Submission{})

    render(conn, "new.html",
      changeset: changeset,
      playlist_id: playlist_id
    )

  end

  def update(conn, %{"id" => id, "status" => status}) do
    sub = Playlists.get_submission!(id)
    playlist = get_playlist_by_id(sub.playlist_id)

    case playlist do
      {:ok, playlist} ->
        cond do
          status == "PENDING" ->
            Email.accepted_email(sub, playlist)
            |> Mailer.deliver_later()
            Playlists.update_submission(sub, %{status: status})

          status == "ACTIVE" ->
            Email.submission_active_email(sub, playlist)
            |> Mailer.deliver_later()
            Playlists.update_submission(sub, %{status: status})

        end


      {:error, error} ->
        conn
        |> put_flash(:info, error)
        |> redirect(to: Routes.admin_path(conn, :index))

    end

    conn
    |> put_flash(:info, "Added to #{status} submissions.")
    |> redirect(to: Routes.admin_path(conn, :index))
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
    |> redirect(to: Routes.admin_path(conn, :index))
  end


end
