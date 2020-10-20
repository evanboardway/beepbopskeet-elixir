defmodule Beepbopskeet.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    field :is_admin, :boolean

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password, :is_admin])
    |> validate_required([:username, :encrypted_password, :is_admin])
    |> unique_constraint(:username)
    |> update_change(:encrypted_password, &Bcrypt.hashpwsalt/1)

  end
end
