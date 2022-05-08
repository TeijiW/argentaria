defmodule ArgentariaWeb.Router do
  use ArgentariaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ArgentariaWeb do
    pipe_through :api

    resources "/balance", Controllers.Balance, only: [:show], param: "account_id", singleton: true
  end
end
