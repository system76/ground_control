defmodule GroundControlWeb.PageLive do
  use GroundControlWeb, :live_view

  alias GroundControl.Cache
  alias GroundControlWeb.Endpoint

  @impl true
  def mount(_params, _session, socket) do
    Endpoint.subscribe("repository_events")

    {:ok, assign(socket, environments: Cache.everything())}
  end

  @impl true
  def handle_info(%{event: "status_change", payload: {environment, repositories}}, %{assigns: assigns} = socket) do
    updated_environments =
      assigns
      |> Map.get(:environments)
      |> Map.put(environment, repositories)

    {:noreply, assign(socket, environments: updated_environments)}
  end
end
