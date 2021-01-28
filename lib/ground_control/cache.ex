defmodule GroundControl.Cache do
  alias GroundControlWeb.Endpoint

  def preload do
    repos = repositories()

    for environment <- environments() do
      Redix.command(:cache, ["SETNX", environment, Jason.encode!(repos)])
    end
  end

  def everything do
    for environment <- environments(), into: %{} do
      {:ok, repositories} = get(environment)
      {environment, Jason.decode!(repositories)}
    end
  end

  def get(environment) do
    Redix.command(:cache, ["GET", environment])
  end

  def put(environment, repository) do
    with {:ok, repositories} <- Redix.command(:cache, ["GET", environment]) do
      slug = "#{repository.owner}/#{repository.name}"

      updated_repositories =
        repositories
        |> Jason.decode!()
        |> Map.put(slug, repository)
        |> Jason.encode!()

      Redix.command(:cache, ["SET", environment, updated_repositories])

      broadcast_change(environment, updated_repositories)
    end
  end

  defp broadcast_change(environment, repositories) do
    Endpoint.broadcast!("repository_events", "status_change", {environment, repositories})
  end

  defp environments do
    Application.get_env(:ground_control, :environments)
  end

  defp repositories do
    for slug <- Application.get_env(:ground_control, :watching), into: %{} do
      [owner, name] = String.split(slug, "/")
      {slug, %{owner: owner, name: name, status: "success"}}
    end
  end
end
