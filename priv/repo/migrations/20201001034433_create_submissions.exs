defmodule Beepbopskeet.Repo.Migrations.CreateSubmissions do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :url, :string
      add :release_date, :naive_datetime

      timestamps()
    end

  end
end
