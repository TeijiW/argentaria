defmodule ArgentariaWeb.EventsView do
  use ArgentariaWeb, :view

  def render("deposit.json", %{account: account}) do
    %{destination: build_account_info(account)}
  end

  def render("withdraw.json", %{account: account}) do
    %{origin: build_account_info(account)}
  end

  def render("transfer.json", %{
        origin_account: origin_account,
        destination_account: destination_account
      }) do
    %{
      origin: build_account_info(origin_account),
      destination: build_account_info(destination_account)
    }
  end

  defp build_account_info(account), do: %{id: account.id, balance: account.balance}
end
