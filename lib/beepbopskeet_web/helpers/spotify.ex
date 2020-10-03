defmodule BeepbopskeetWeb.Helpers.Spotify do

  def get_spotify_token do
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

  def get_playlists() do
    token = get_spotify_token()
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

  def get_playlist_by_id(playlist_id) do
    token = get_spotify_token()

    response =
      HTTPoison.request(
        :get,
        "https://api.spotify.com/v1/playlists/#{playlist_id}?fields=description,images,followers,name,uri",
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
          |> keys_to_atoms()

        desc =
          extraction
          |> Map.take([:description])

        fol =
          extraction
          |> Map.take([:followers])

        temp =
          extraction
          |> Map.take([:name])
          |> Map.get(:name)
          |> String.upcase()

        name = Map.new(name: temp)

        uri =
          extraction
          |> Map.take([:uri])

        images =
          extraction
          |> Map.take([:images])
          |> Map.get(:images)
          |> Enum.at(0)
          |> keys_to_atoms()

        plst =
          Map.merge(desc, fol)
          |> Map.merge(name)
          |> Map.merge(uri)
          |> Map.merge(images)
          |> Map.merge(fol)
          |> Map.put(:error, false)

        {:ok, plst}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, Map.new(error: true)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, Map.new(error: true)}
    end
  end




  def keys_to_atoms(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), keys_to_atoms(val)}
  end

  def keys_to_atoms(value), do: value

end
