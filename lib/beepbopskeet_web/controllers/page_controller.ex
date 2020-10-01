defmodule BeepbopskeetWeb.PageController do
  use BeepbopskeetWeb, :controller
  use HTTPoison.Base
  import Poison

  import BeepbopskeetWeb.Helpers.Auth

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def spotify_playlists(conn, _params) do
    token = get_token()
    data = get_playlists(token)

    case data do
      {:ok, playlists} ->
        one =
          playlists
          |> Enum.map(fn playlist ->
            urls =
              playlist
              |> Map.take([:external_urls])

            id =
              playlist
              |> Map.take([:id])

            test =
              playlist
              |> Map.take([:name])
              |> Map.get(:name)
              |> String.upcase()

            names = Map.new(name: test)

            image =
              playlist
              |> Map.take([:images])
              |> Map.get(:images)
              |> Enum.at(0)
              |> keys_to_atoms()

            Map.merge(urls, names)
            |> Map.merge(image)
            |> Map.merge(id)
          end)

        render(conn, "playlists.html", playlists: one)

      {:error, error} ->
        render(conn, "error.html", error: error)
    end
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

  defp get_playlists(token) do
    url = "https://api.spotify.com/v1/users/carmenelainee/playlists"

    response =
      HTTPoison.request(
        :get,
        url,
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
          |> Map.take(["items"])
          |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          |> Enum.at(0)
          |> elem(1)
          |> Enum.map(fn playlist -> keys_to_atoms(playlist) end)

        {:ok, extraction}

      {:error, _} ->
        {:error, "An error has occured"}
    end
  end

  def keys_to_atoms(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), keys_to_atoms(val)}
  end

  def keys_to_atoms(value), do: value
end

# External url, image, name, followers
