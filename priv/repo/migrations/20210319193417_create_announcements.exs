defmodule Beepbopskeet.Repo.Migrations.CreateAnnouncements do
  use Ecto.Migration

  def change do
    create table(:announcements) do
      add :body, :string

      timestamps()
    end

  end
end
