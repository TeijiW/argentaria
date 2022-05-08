defmodule ArgentariaWeb.Router do
  use ArgentariaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ArgentariaWeb do
    pipe_through :api

    resources "/balance", BalanceController, only: [:show], singleton: true
  end
end
