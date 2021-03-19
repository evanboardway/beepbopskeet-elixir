# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Beepbopskeet.Repo.insert!(%Beepbopskeet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Beepbopskeet.Accounts
Accounts.create_user(
  %{
    username: "beepbop",
    encrypted_password: "skeet",
    is_admin: true
  }
)

# alias Beepbopskeet.Admin
# Admin.create_announcement(
#   %{
#     body: "Change Me"
#   }
# )
