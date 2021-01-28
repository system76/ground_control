import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

live_view_salt =
  System.get_env("LIVE_VIEW_SALT") ||
    raise """
    environment variable LIVE_VIEW_SALT is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :ground_control, GroundControlWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base,
  live_view: [signing_salt: live_view_salt],
  url: [scheme: "https", host: "ground-control-to-major-tom.herokuapp.com"],
  server: true

config :ground_control,
  redix: {System.get_env("REDIS_URL"), [name: :cache]},
  github_secret: System.get_env("GITHUB_SECRET")
