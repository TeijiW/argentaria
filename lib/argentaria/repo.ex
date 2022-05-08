defmodule Argentaria.Repo do
  use Ecto.Repo,
    otp_app: :argentaria,
    adapter: Ecto.Adapters.Postgres
end
