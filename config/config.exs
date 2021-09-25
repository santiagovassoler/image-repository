# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :imagerepository,
  ecto_repos: [Imagerepository.Repo]

config :batch_loader, :default_repo, Imagerepository.Repo

# Configures the endpoint
config :imagerepository, ImagerepositoryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KVqTcxUpH0czfYlGl06PNtslGRqjEjSaph82qQe2X/gWOnFqUgS2MpQ6Tqsh8bKt",
  render_errors: [view: ImagerepositoryWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Imagerepository.PubSub,
  live_view: [signing_salt: "DWzXMarw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
