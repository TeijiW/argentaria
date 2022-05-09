defmodule Argentaria.Events do
  alias Argentaria.Accounts
  alias Accounts.Account

  def operation(
        %{"amount" => amount, "destination" => account_id},
        operation = "deposit"
      ),
      do: operation(account_id, amount, operation)

  def operation(%{"amount" => amount, "origin" => account_id}, operation = "withdraw"),
    do: operation(account_id, amount, operation)

  def operation(account_id, amount, operation) do
    operation_atom = String.to_atom(operation)
    result = Accounts.get_one(account_id)
    apply(__MODULE__, operation_atom, [result, account_id, amount])
  end

  def deposit({:ok, %Account{} = account}, _account_id, amount),
    do: Accounts.update(account, %{balance: account.balance + amount})

  def deposit({:error, :not_found}, account_id, amount),
    do: Accounts.insert(%{id: account_id, balance: amount})

  def withdraw({:ok, %Account{} = account}, _account_id, amount),
    do: Accounts.update(account, %{balance: account.balance - amount})

  def withdraw({:error, :not_found} = error, _account_id, _amount), do: error
end
