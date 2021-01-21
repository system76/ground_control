defmodule Radar.Repo do
  use Ecto.Repo,
    otp_app: :radar,
    adapter: Ecto.Adapters.Postgres
end
