defmodule Beepbopskeet.Repo.Migrations.AddNameToSubmission do
  use Ecto.Migration

  def change do
    alter table("submissions") do
      add :playlist_id, :string
    end

  end
end
