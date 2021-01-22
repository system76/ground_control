# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :ground_control, GroundControlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EIAye2ATKMv8hAy/fVOshtoOcrlfpZrXZE/DVBzsQ+XU3u+dmkH7vOdXhKJPSADE",
  render_errors: [view: GroundControlWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GroundControl.PubSub,
  live_view: [signing_salt: "3VFwAomF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ground_control,
  github_secret: "",
  environments: [],
  watching: []

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
