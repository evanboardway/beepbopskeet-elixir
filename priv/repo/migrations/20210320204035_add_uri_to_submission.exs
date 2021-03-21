defmodule Beepbopskeet.Repo.Migrations.AddUriToSubmission do
  use Ecto.Migration

  def change do
    alter table("submissions") do
      add :uri, :string
    end

  end
end
