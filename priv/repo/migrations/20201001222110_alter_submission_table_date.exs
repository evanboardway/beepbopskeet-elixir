defmodule Beepbopskeet.Repo.Migrations.AlterSubmissionTableDate do
  use Ecto.Migration

  def change do
    alter table("submissions") do
      remove :release_date
      add :release_date, :string
    end
  end
end
