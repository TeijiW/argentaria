defmodule ArgentariaWeb.EventsView do
  use ArgentariaWeb, :view

  def render("deposit.json", %{account: account}) do
    %{destination: build_account_info(account)}
  end

  def render("withdraw.json", %{account: account}) do
    %{origin: build_account_info(account)}
  end

  defp build_account_info(account), do: %{id: account.id, balance: account.balance}
end
