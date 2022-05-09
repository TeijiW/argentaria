defmodule ArgentariaWeb.Router do
  use ArgentariaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ArgentariaWeb do
    pipe_through :api

    resources "/balance", BalanceController, only: [:show], singleton: true
    resources "/event", EventsController, only: [:create]
    resources "/reset", ResetController, only: [:create]
  end
end
