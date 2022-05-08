defmodule Argentaria.Support.AccountsFixtures do
  alias Argentaria.Accounts
  defdelegate insert_account(attrs), to: Accounts, as: :insert
end
