defmodule ArgentariaWeb.EventsControllerTest do
  use ArgentariaWeb.ConnCase, async: true
  import Argentaria.Support.AccountsFixtures

  describe "Deposit" do
    test "for non-existing account", %{conn: conn} do
      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "deposit"}), %{
                 "destination" => 1,
                 "amount" => 500
               })
               |> json_response(201)

      assert response["destination"] == %{"id" => 1, "balance" => 500}
    end

    test "for existing account", %{conn: conn} do
      insert_account(%{id: 349, balance: 123})

      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "deposit"}), %{
                 "destination" => 349,
                 "amount" => 7
               })
               |> json_response(201)

      assert response["destination"] == %{"id" => 349, "balance" => 130}
    end
  end

  describe "Withdraw" do
    test "from non-existing account", %{conn: conn} do
      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "withdraw"}), %{
                 "origin" => 1,
                 "amount" => 500
               })
               |> json_response(404)

      assert response == 0
    end

    test "from existing account", %{conn: conn} do
      insert_account(%{id: 1, balance: 500})

      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "withdraw"}), %{
                 "origin" => 1,
                 "amount" => 200
               })
               |> json_response(201)

      assert response["origin"] == %{"id" => 1, "balance" => 300}
    end
  end

  describe "Transfer" do
    test "from non-existing account to non-existing account", %{conn: conn} do
      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "transfer"}), %{
                 "origin" => 1,
                 "destination" => 2,
                 "amount" => 500
               })
               |> json_response(404)

      assert response == 0
    end

    test "from non-existing account to existing account", %{conn: conn} do
      insert_account(%{id: 2, balance: 0})

      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "transfer"}), %{
                 "origin" => 1,
                 "destination" => 2,
                 "amount" => 500
               })
               |> json_response(404)

      assert response == 0
    end

    test "from existing account to non-existing account", %{conn: conn} do
      insert_account(%{id: 1, balance: 50})

      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "transfer"}), %{
                 "origin" => 1,
                 "destination" => 2,
                 "amount" => 50
               })
               |> json_response(201)

      assert response["origin"] == %{"id" => 1, "balance" => 0}
      assert response["destination"] == %{"id" => 2, "balance" => 50}
    end

    test "from existing account to existing account", %{conn: conn} do
      insert_account(%{id: 1, balance: 50})
      insert_account(%{id: 2, balance: 100})

      assert response =
               conn
               |> post(Routes.events_path(conn, :create, %{"type" => "transfer"}), %{
                 "origin" => 1,
                 "destination" => 2,
                 "amount" => 50
               })
               |> json_response(201)

      assert response["origin"] == %{"id" => 1, "balance" => 0}
      assert response["destination"] == %{"id" => 2, "balance" => 150}
    end
  end
end
