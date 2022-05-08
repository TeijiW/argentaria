defmodule ArgentariaWeb.EventsController do
  use ArgentariaWeb, :controller
  alias Argentaria.Accounts
  alias Accounts.Account

  def create(
        conn,
        %{"type" => "deposit", "destination" => account_id, "amount" => value} = _params
      ) do
    account_id
    |> Accounts.get_one()
    |> save_account({account_id, value})
    |> handle_save_response(conn, :deposit)
  end

  defp save_account({:ok, account = %Account{}}, {_account_id, value}),
    do: Accounts.update(account, %{balance: account.balance + value})

  defp save_account({:error, :not_found}, {account_id, value}),
    do: Accounts.insert(%{id: account_id, balance: value})

  defp handle_save_response({:ok, account}, conn, :deposit) do
    conn
    |> put_status(:created)
    |> render("deposit.json", account: account)
  end

  defp handle_save_response({:error, changeset}, conn, _event_type) do
    nil
  end
end
