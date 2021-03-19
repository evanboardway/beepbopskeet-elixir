defmodule Beepbopskeet.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :title, :string
      add :link, :string
      add :material_icon_title, :string
      add :category, :string

      timestamps()
    end

  end
end
