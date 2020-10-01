defmodule BeepbopskeetWeb.SubmissionController do
  use BeepbopskeetWeb, :controller
  use HTTPoison.Base
  import Poison

  alias Beepbopskeet.Playlists
  alias Beepbopskeet.Playlists.Submission

  def index(conn, _params) do
    submissions = Playlists.list_submissions()
    render(conn, "index.html", submissions: submissions)
  end

  def new(conn, %{"playlist_id" => playlist_id, "playlist_name" => playlist_name}) do
    IO.inspect(playlist_id, label: "PLAYLISTID")

    playlist = get_playlist_by_id(playlist_id)

    case playlist do
      {:ok, playlist} ->
        playlist
        |> IO.inspect()

      {:error, error} ->
        nil
    end

    changeset = Playlists.change_submission(%Submission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"submission" => submission_params}) do
    case Playlists.create_submission(submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission created successfully.")
        |> redirect(to: Routes.pate_path(conn, :spotify_playlists))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    submission = Playlists.get_submission!(id)
    {:ok, _submission} = Playlists.delete_submission(submission)

    conn
    |> put_flash(:info, "Submission deleted successfully.")
    |> redirect(to: Routes.submission_path(conn, :index))
  end

  defp get_token do
    client_creds = "5197bfdc2195422bb9b19099a74a87ca:d37cc39b17c542ceb81f7b463f43bb2c"
    _client_secret = "d37cc39b17c542ceb81f7b463f43bb2c"

    encoded = Base.encode64("#{client_creds}")

    response =
      HTTPoison.request(
        :post,
        "https://accounts.spotify.com/api/token?grant_type=client_credentials",
        "",
        [
          {"Content-Type", "application/x-www-form-urlencoded"},
          {"Authorization",
           "Basic NTE5N2JmZGMyMTk1NDIyYmI5YjE5MDk5YTc0YTg3Y2E6MTU1Y2RmNmZkMmVjNGJkNGE2OWMyMTNmMjljZTBiNDI="}
        ]
      )

    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body
        |> Poison.decode!()
        |> Map.take(["access_token"])
        |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
        |> Enum.at(0)
        |> elem(1)

      {:error, _} ->
        {:error, "An error has occured."}
    end
  end

  defp get_playlist_by_id(playlist_id) do
    token = get_token()
    IO.inspect(token, label: "TOKEN")

    response =
      HTTPoison.request(
        :get,
        "https://api.spotify.com/v1/playlists/#{playlist_id}",
        "",
        [
          {"Content-Type", "application/json"},
          {"Authorization", "Bearer #{token}"}
        ]
      )

    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        extraction =
          body
          |> Poison.decode!()
          |> IO.inspect()
          # |> Map.take(["items"])
          # |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          # |> Enum.at(0)
          # |> elem(1)
          # |> Enum.map(fn playlist -> keys_to_atoms(playlist) end)

        {:ok, extraction}

      {:error, _} ->
        {:error, "An error has occured"}
    end
  end

  defp keys_to_atoms(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), keys_to_atoms(val)}
  end

  defp keys_to_atoms(value), do: value

end
