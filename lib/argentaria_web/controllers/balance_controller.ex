defmodule ArgentariaWeb.BalanceController do
  use ArgentariaWeb, :controller
  alias Argentaria.Accounts

  action_fallback ArgentariaWeb.FallbackController

  def show(conn, %{"account_id" => account_id} = _params) do
    with {:ok, account = %Accounts.Account{}} <- Accounts.get_one(account_id),
         do: json(conn, account.balance)
  end
end
