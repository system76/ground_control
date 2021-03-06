defmodule GroundControl.Events do
  require Logger

  alias GroundControl.Cache

  @watching Application.get_env(:ground_control, :watching)

  def handle_event(params) do
    with %{
           "workflow" => %{"name" => "Deploy " <> env},
           "workflow_run" => %{"conclusion" => conclusion, "head_sha" => head_sha},
           "repository" => %{"name" => repo_name, "owner" => %{"login" => owner}}
         } <- params,
         true <- watching?(owner, repo_name) do
      Logger.info("Handling #{env} Deploy event")

      repo = %{
        owner: owner,
        name: repo_name,
        sha: String.slice(head_sha, 0..7),
        status: determine_status(conclusion)
      }

      Cache.put(env, repo)
    end
  end

  defp watching?(owner, repo), do: "#{owner}/#{repo}" in @watching

  defp determine_status(nil), do: "running"
  defp determine_status(status), do: status
end
