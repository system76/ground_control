defmodule GroundControl.Events do
  alias GroundControl.Repository
  alias GroundControlWeb.Endpoint

  def handle_event(check_run, repository) do
    %{"name" => _check_name, "conclusion" => conclusion} = check_run
    %{"name" => repo_name, "owner" => %{"login" => owner}} = repository

    Endpoint.broadcast!("repository_events", "status_change", %Repository{
      owner: owner,
      name: repo_name,
      status: determine_status(conclusion)
    })
  end

  defp determine_status(nil), do: "running"
  defp determine_status(status), do: status
end
