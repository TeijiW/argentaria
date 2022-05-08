defmodule ArgentariaWeb.Controllers.Balance do
  use ArgentariaWeb, :controller
  alias Argentaria.Accounts

  def show(conn, %{"account_id" => account_id} = _params) do
    account_id |> Accounts.get_one() |> handle_response(conn)
  end

  defp handle_response({:ok, account}, conn), do: json(conn, account)
  defp handle_response(error, _conn), do: error
end
