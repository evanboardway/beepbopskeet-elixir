defmodule Beepbopskeet.Playlists.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  alias Beepbopskeet.Playlists

  schema "submissions" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :release_date, :string
    field :url, :string
    field :uri, :string
    field :playlist_id, :string
    field :status, :string

    timestamps()
  end

  defp validate_link(sub) do
    case get_field(sub, :url) do
      nil -> sub
      url ->
        case String.contains?(url, "open.spotify.com") do
          true -> sub
          false -> add_error(sub, :url, "must be a valid spotify link")
        end
    end
  end

  # Query by uid, if more than three across  any of the playlists then deny.
  # If already submitted, or the playlist id's are the same, tell them that you can only submit once.
  defp validate_unique(sub) do
    case get_field(sub, :uri) do
      nil -> sub
      uri ->
        matching_uids = Playlists.get_submission_by_uri!(uri)
        cond do
          Enum.count(matching_uids) == 0 ->
            sub

          Enum.count(matching_uids) > 0 ->
            # If sub.playlist_id in matching_uids.playlist_id
            cond do
              Enum.filter(matching_uids, fn match ->
                match.playlist_id == get_field(sub, :playlist_id)
              end)
              |> Enum.count() >= 1 ->
                add_error(sub, :uri, "you may only submit a song once per playlist")

              Enum.count(matching_uids) >= 3 ->
                add_error(sub, :uri, "this song has too many active submissions")

              true -> sub
            end
        end
    end
  end

  defp validate_corresponds(sub) do
    case get_field(sub, :uri) do
      nil -> sub
      uri ->
        case get_field(sub, :url) do
          nil -> sub
          url ->
            parsed_uri = String.split(uri, ":") |> Enum.at(2)

            url_cut =
              String.split(url, ["/", "?"])
              |> Enum.filter(fn e ->
                String.equivalent?(e, parsed_uri)
              end)

            cond do
              Enum.count(url_cut) > 0 -> sub
              true -> add_error(sub, :url, "song link doesn't correspond to provided uri")
            end
        end
    end
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:first_name, :last_name, :email, :url, :uri, :release_date, :playlist_id, :status])
    |> validate_required([:first_name, :email, :url, :uri, :release_date, :playlist_id, :status])
    |> validate_format(:email, ~r/@/)
    |> validate_format(:release_date, ~r/^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/)
    |> validate_link()
    |> validate_unique()
    |> validate_corresponds()
  end

end
