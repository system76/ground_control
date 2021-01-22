defmodule RadarWeb.PageLive do
  use RadarWeb, :live_view

  alias Radar.Repository
  alias RadarWeb.Endpoint

  @impl true
  def mount(_params, _session, socket) do
    Endpoint.subscribe("repository_events")
    {:ok, assign(socket, repositories: repositories())}
  end

  def handle_info(%{event: "status_change", payload: payload}, socket) do
    repositories =
      socket.assigns
      |> Map.get(:repositories)
      |> Enum.map(fn el ->
        if(el.name == payload.name && el.owner == payload.owner) do
          payload
        else
          el
        end
      end)

    {:noreply, assign(socket, repositories: repositories)}
  end

  defp repositories do
    for name <- Application.get_env(:radar, :watching) do
      [owner, name] = String.split(name, "/", trim: true)
      %Repository{owner: owner, name: name, status: "success"}
    end
  end
end
