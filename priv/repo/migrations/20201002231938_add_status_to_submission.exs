defmodule Beepbopskeet.Repo.Migrations.AddStatusToSubmission do
  use Ecto.Migration

  def change do
    alter table("submissions") do
      add :status, :string
    end
  end
end
