defmodule Argentaria.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:balance, :id]

  @primary_key {:id, :id, autogenerate: false}
  schema "accounts" do
    field(:balance, :decimal)
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, attrs),
    do:
      struct
      |> cast(attrs, @fields)
      |> validate_required(@fields)
      |> unique_constraint(:id, name: :accounts_pkey)
end
