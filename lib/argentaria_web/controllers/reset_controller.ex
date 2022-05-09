defmodule ArgentariaWeb.ResetController do
  use ArgentariaWeb, :controller
  alias Argentaria.Accounts

  def create(conn, _params) do
    Accounts.delete_all()
    text(conn, "OK")
  end
end
