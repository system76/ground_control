# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :radar,
  ecto_repos: [Radar.Repo]

# Configures the endpoint
config :radar, RadarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EIAye2ATKMv8hAy/fVOshtoOcrlfpZrXZE/DVBzsQ+XU3u+dmkH7vOdXhKJPSADE",
  render_errors: [view: RadarWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Radar.PubSub,
  live_view: [signing_salt: "3VFwAomF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
