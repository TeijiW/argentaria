defmodule Argentaria.Accounts do
  alias Argentaria.Accounts.Account
  alias Argentaria.Repo

  def get_one(account_id) do
    case Repo.get(Account, account_id) do
      %Account{} = account -> {:ok, account}
      nil -> {:error, :not_found}
    end
  end
end
