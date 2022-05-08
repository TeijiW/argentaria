defmodule ArgentariaWeb.EventsView do
  use ArgentariaWeb, :view

  def render("deposit.json", %{account: account}) do
    %{destination: %{id: account.id, balance: account.balance}}
  end
end
