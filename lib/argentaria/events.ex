defmodule Argentaria.Events do
  alias Argentaria.Accounts
  alias Accounts.Account

  def operation(%{"amount" => amount, "destination" => account_id}, operation = "deposit"),
    do: handle_operation(account_id, amount, operation)

  def operation(%{"amount" => amount, "origin" => account_id}, operation = "withdraw"),
    do: handle_operation(account_id, amount, operation)

  defp handle_operation(account_id, amount, operation) do
    get_result = Accounts.get_one(account_id)

    case operation do
      "deposit" -> deposit(get_result, account_id, amount)
      "withdraw" -> withdraw(get_result, account_id, amount)
    end
  end

  defp deposit({:ok, %Account{} = account}, _account_id, amount),
    do: Accounts.update(account, %{balance: account.balance + amount})

  defp deposit({:error, :not_found}, account_id, amount),
    do: Accounts.insert(%{id: account_id, balance: amount})

  defp withdraw({:ok, %Account{} = account}, _account_id, amount),
    do: Accounts.update(account, %{balance: account.balance - amount})

  defp withdraw({:error, :not_found} = error, _account_id, _amount), do: error
end
