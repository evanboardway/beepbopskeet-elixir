defmodule Beepbopskeet.Admin.Announcement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "announcements" do
    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(announcement, attrs) do
    announcement
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
