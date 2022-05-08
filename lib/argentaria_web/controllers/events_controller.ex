defmodule ArgentariaWeb.EventsController do
  use ArgentariaWeb, :controller
  alias Argentaria.Accounts
  alias Accounts.Account

  action_fallback ArgentariaWeb.FallbackController

  def create(
        conn,
        %{"type" => "deposit", "destination" => account_id, "amount" => value} = _params
      ) do
    account_id
    |> Accounts.get_one()
    |> save_account({account_id, value})
    |> handle_response(conn, :deposit)
  end

  def create(
        conn,
        %{"type" => "withdraw", "origin" => account_id, "amount" => value} = _params
      ) do
    account_id
    |> Accounts.get_one()
    |> subtract_from_account({account_id, value})
    |> handle_response(conn, :withdraw)
  end

  defp subtract_from_account({:ok, account = %Account{}}, {_account_id, value}),
    do: Accounts.update(account, %{balance: account.balance - value})

  defp subtract_from_account({:error, :not_found}, _params), do: {:error, :not_found}

  defp save_account({:ok, account = %Account{}}, {_account_id, value}),
    do: Accounts.update(account, %{balance: account.balance + value})

  defp save_account({:error, :not_found}, {account_id, value}),
    do: Accounts.insert(%{id: account_id, balance: value})

  defp handle_response({:ok, account}, conn, :deposit) do
    conn
    |> put_status(:created)
    |> render("deposit.json", account: account)
  end

  defp handle_response({:ok, account}, conn, :withdraw) do
    conn
    |> put_status(:created)
    |> render("withdraw.json", account: account)
  end

  defp handle_response({:error, _reason} = error, _conn, _event_type), do: error
end
