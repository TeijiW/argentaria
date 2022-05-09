defmodule ArgentariaWeb.EventsController do
  use ArgentariaWeb, :controller
  alias Argentaria.Events

  action_fallback ArgentariaWeb.FallbackController

  def create(
        conn,
        %{"type" => event_type} = params
      ) do
    params
    |> Events.operation(event_type)
    |> handle_response(conn, event_type)
  end

  defp handle_response({:ok, account}, conn, event_type) do
    render_pattern = "#{event_type}.json"

    conn
    |> put_status(:created)
    |> render(render_pattern, account: account)
  end

  defp handle_response({:error, _reason} = error, _conn, _event_type), do: error
end
