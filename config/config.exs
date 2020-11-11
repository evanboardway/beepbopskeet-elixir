# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :beepbopskeet,
  ecto_repos: [Beepbopskeet.Repo],
  spotify_client_secret: System.get_env("SPOTIFY_CLIENT_SECRET"),
  spotify_client_id: System.get_env("SPOTIFY_CLIENT_ID")

# Configures the endpoint
config :beepbopskeet, BeepbopskeetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hDwXSJ7ZuZW8UbQ5d1RKsYtiryg++8YG/JQSOO+tk52IdB+vDkudCDH26pld999o",
  render_errors: [view: BeepbopskeetWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Beepbopskeet.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "42/QKQnN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
