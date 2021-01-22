defmodule GroundControl.Events do
  require Logger

  alias GroundControl.Repository
  alias GroundControlWeb.Endpoint

  def handle_event(params) do
    with %{
           "workflow" => %{"name" => "Deploy " <> env},
           "workflow_run" => %{"conclusion" => conclusion},
           "repository" => %{"name" => repo_name, "owner" => %{"login" => owner}}
         } <- params do
      Logger.info("Handling #{env} Deploy event")

      repo = %Repository{
        owner: owner,
        name: repo_name,
        status: determine_status(conclusion)
      }

      Endpoint.broadcast!("repository_events", "status_change", {env, repo})
    end
  end

  defp determine_status(nil), do: "running"
  defp determine_status(status), do: status
end
