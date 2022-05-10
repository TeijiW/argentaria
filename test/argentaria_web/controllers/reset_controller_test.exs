defmodule ArgentariaWeb.ResetControllerTest do
  use ArgentariaWeb.ConnCase, async: true
  import Argentaria.Support.AccountsFixtures
  alias Argentaria.Repo
  alias Argentaria.Accounts.Account

  test "Reset database", %{conn: conn} do
    insert_account(%{id: 1, balance: 5.2})

    assert response =
             conn
             |> post(Routes.reset_path(conn, :create, %{"type" => "reset"}))
             |> text_response(200)

    assert response == "OK"
    assert [] = Repo.all(Account)
  end
end
