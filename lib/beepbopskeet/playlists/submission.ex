defmodule Beepbopskeet.Playlists.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :release_date, :naive_datetime
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:first_name, :last_name, :email, :url, :release_date])
    |> validate_required([:first_name, :last_name, :email, :url, :release_date])
  end

end
