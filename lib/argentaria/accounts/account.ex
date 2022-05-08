defmodule Argentaria.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field(:balance, :decimal)
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, attrs),
    do: struct |> cast(attrs, [:balance]) |> validate_required([:balance])
end
