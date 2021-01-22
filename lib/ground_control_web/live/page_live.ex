defmodule GroundControlWeb.PageLive do
  use GroundControlWeb, :live_view

  alias GroundControl.Repository
  alias GroundControlWeb.Endpoint

  @impl true
  def mount(_params, _session, socket) do
    Endpoint.subscribe("repository_events")
    {:ok, assign(socket, environments: environments())}
  end

  @impl true
  def handle_info(%{event: "status_change", payload: {environment, payload}}, %{assigns: assigns} = socket) do
    repos = get_in(assigns, [:environments, environment])

    updated_repos =
      repos
      |> Enum.map(fn el ->
        if(el.name == payload.name && el.owner == payload.owner) do
          payload
        else
          el
        end
      end)

    updated_environment =
      assigns
      |> Map.get(:environments)
      |> Map.put(environment, updated_repos)

    {:noreply, assign(socket, environments: updated_environment)}
  end

  defp environments do
    envs = Application.get_env(:ground_control, :environments)
    repos = repositories()

    Enum.into(envs, %{}, fn env ->
      {env, repos}
    end)
  end

  defp repositories do
    for name <- Application.get_env(:ground_control, :watching) do
      [owner, name] = String.split(name, "/", trim: true)
      %Repository{owner: owner, name: name, status: "success"}
    end
  end
end
