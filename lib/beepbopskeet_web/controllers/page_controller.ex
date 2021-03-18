defmodule BeepbopskeetWeb.PageController do
  use BeepbopskeetWeb, :controller
  use HTTPoison.Base

  import Poison
  import BeepbopskeetWeb.Helpers.Auth
  import BeepbopskeetWeb.Helpers.Spotify

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def spotify_playlists(conn, _params) do
    data = get_playlists()

    case data do
      {:ok, playlists} ->
        plsts =
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

        render(conn, "playlists.html", playlists: plsts)

      {:error, error} ->
        render(conn, "error.html", error: error)
    end
  end

end

# External url, image, name, followers
