use Mix.Config

config :ground_control, GroundControlWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :logger, level: :info
