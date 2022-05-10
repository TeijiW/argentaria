defmodule Argentaria.Operations do
  alias Argentaria.Accounts
  alias Accounts.Account

  @doc """
  `call/2` redirects to execution of operation based on event type
  """
  def call(%{"amount" => amount, "destination" => account_id}, "deposit"),
    do: account_id |> Accounts.get_one() |> deposit(account_id, amount)

  def call(%{"amount" => amount, "origin" => account_id}, "withdraw"),
    do: account_id |> Accounts.get_one() |> withdraw(account_id, amount)

  def call(
        %{
          "amount" => amount,
          "destination" => destination_account_id,
          "origin" => origin_account_id
        },
        "transfer"
      ) do
    origin_account = Accounts.get_one(origin_account_id)

    destination_account =
      Accounts.get_one(destination_account_id) ||
        %Account{balance: 0, id: handle_id(destination_account_id)}

    case origin_account do
      %Account{} ->
        Accounts.transfer_balance(origin_account, destination_account, amount)

      nil ->
        {:error, :not_found}
    end
  end

  defp deposit(%Account{} = account, _account_id, amount),
    do: Accounts.update(account, %{balance: account.balance + amount})

  defp deposit(nil, account_id, amount),
    do: Accounts.insert(%{id: account_id, balance: amount})

  defp withdraw(%Account{} = account, _account_id, amount),
    do: Accounts.update(account, %{balance: account.balance - amount})

  defp withdraw(nil, _account_id, _amount), do: {:error, :not_found}

  defp handle_id(id) when is_binary(id), do: String.to_integer(id)
  defp handle_id(id), do: id
end
