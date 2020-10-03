defmodule BeepbopskeetWeb.SubmissionView do
  use BeepbopskeetWeb, :view

  import BeepbopskeetWeb.Helpers.Spotify

  def playlist_from_id(id) do
    playlist = get_playlist_by_id(id)

    case playlist do
      {:ok, plst} -> plst
      {:error, error} -> error
    end
  end

end
