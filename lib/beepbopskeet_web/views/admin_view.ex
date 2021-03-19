defmodule BeepbopskeetWeb.AdminView do
  use BeepbopskeetWeb, :view

  alias Beepbopskeet.Playlists

  import BeepbopskeetWeb.Helpers.Spotify

  def incoming do
    Playlists.list_incoming()
  end

  def active do
    Playlists.list_active()
  end

  def pending do
    Playlists.list_pending()
  end

  def get_playlist_name(id) do
    case get_playlist_by_id(id) do
      {:ok, playlist} -> playlist.name
      {:error, error} -> error
    end

  end
end
