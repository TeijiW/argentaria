defmodule ArgentariaWeb.BalanceControllerTest do
  use ArgentariaWeb.ConnCase, async: true
  import Argentaria.Support.AccountsFixtures

  describe "Get the balance from account" do
    setup do
      insert_account(%{id: 5, balance: 312.2})
      :ok
    end

    test "returns 200 and the account balance when account exists", %{conn: conn} do
      assert response =
               conn
               |> get(Routes.balance_path(conn, :show, %{"account_id" => 5}))
               |> json_response(200)

      assert response == 312.2
    end

    test "returns 404 and balance 0 when account does not exist", %{conn: conn} do
      assert response =
               conn
               |> get(Routes.balance_path(conn, :show, %{"account_id" => 1}))
               |> json_response(404)

      assert response == 0
    end
  end
end
