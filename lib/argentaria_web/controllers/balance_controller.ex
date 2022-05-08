defmodule ArgentariaWeb.BalanceController do
  use ArgentariaWeb, :controller
  alias Argentaria.Accounts

  def show(conn, %{"account_id" => account_id} = _params) do
    case Accounts.get_one(account_id) do
      {:ok, account} ->
        json(conn, account.balance)

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(0)
    end
  end
end
