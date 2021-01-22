defmodule GroundControlWeb.WebhookController do
  use GroundControlWeb, :controller

  require Logger

  alias GroundControl.Events

  plug :verify_signature

  def create(conn, params) do
    handle_event(params)

    send_resp(conn, 200, Jason.encode!(%{msg: "Thanks"}))
  end

  defp handle_event(%{"check_run" => check_run, "repository" => repository}) do
    Logger.info("Handling webhook")
    Events.handle_event(check_run, repository)
  end

  defp handle_event(_) do
    Logger.debug("Ignored webhook")
    :ignored
  end

  defp compute_signature(%{private: %{raw_body: body}}) do
    :sha256
    |> :crypto.hmac(github_secret(), body)
    |> Base.encode16(case: :lower)
  end

  defp verify_signature(conn, _opts) do
    with ["sha256=" <> signature] <- Plug.Conn.get_req_header(conn, "x-hub-signature-256"),
         expected_signature = compute_signature(conn),
         true <- Plug.Crypto.secure_compare(expected_signature, signature) do
      conn
    else
      _ ->
        conn
        |> send_resp(401, Jason.encode!(%{msg: "You shall not pass!"}))
        |> halt()
    end
  end

  defp github_secret, do: Application.get_env(:ground_control, :github_secret)
end
