defmodule Notecastapp.Repo do
  use Ecto.Repo,
    otp_app: :notecastapp,
    adapter: Ecto.Adapters.Postgres
end
