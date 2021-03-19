defmodule Beepbopskeet.Admin.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :link, :string
    field :title, :string
    field :material_icon_title, :string
    field :category, :string

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :link, :material_icon_title, :category])
    |> validate_required([:title, :link, :category])
  end


  def validate_category(cat) do
    cat == "SOCIALS" || cat == "GENERAL"
  end
end
