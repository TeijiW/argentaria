defmodule ArgentariaWeb.FallbackController do
  use ArgentariaWeb, :controller

  def call(conn, {:error, :not_found}), do: conn |> put_status(:not_found) |> json(0)
  def call(conn, nil), do: conn |> put_status(:not_found) |> json(0)
end
