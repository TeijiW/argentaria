defmodule Argentaria.Accounts do
  alias Argentaria.Accounts.Account
  alias Argentaria.Repo
  alias Ecto.Multi

  def delete_all, do: Repo.delete_all(Account)

  def get_one(account_id), do: Repo.get(Account, account_id)

  def insert(attrs) do
    attrs |> Account.changeset() |> Repo.insert()
  end

  def update(account, attrs) do
    account |> Account.changeset(attrs) |> Repo.update()
  end

  def transfer_balance(origin, destination, amount) do
    origin_changeset = Account.changeset(origin, %{balance: origin.balance - amount})

    destination_changeset =
      Account.changeset(destination, %{balance: destination.balance + amount})

    Multi.new()
    |> Multi.update(:origin_account, origin_changeset)
    |> Multi.insert_or_update(:destination_account, destination_changeset)
    |> Repo.transaction()
  end
end
