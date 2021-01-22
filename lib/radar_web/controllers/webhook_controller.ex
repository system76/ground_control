defmodule RadarWeb.WebhookController do
  use RadarWeb, :controller

  alias Radar.Repository
  alias RadarWeb.Endpoint

  def create(conn, %{"owner" => owner, "name" => name, "status" => status}) do
    Endpoint.broadcast!("repository_events", "status_change", %Repository{
      owner: owner,
      name: name,
      status: status
    })

    send_resp(conn, 204, "")
  end
end
