defmodule Cryptrage.Repo do
  use Ecto.Repo,
    otp_app: :cryptrage,
    adapter: Ecto.Adapters.Postgres
end
