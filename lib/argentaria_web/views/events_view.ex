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

  defp build_account_info(account),
    do: %{id: account.id, balance: maybe_convert_to_int(account.balance)}

  defp maybe_convert_to_int(value) do
    rounded_value = round(value)
    if rounded_value == value, do: rounded_value, else: value
  end
end
