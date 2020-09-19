defmodule Beepbopskeet.Repo do
  use Ecto.Repo,
    otp_app: :beepbopskeet,
    adapter: Ecto.Adapters.Postgres
end
