defmodule EventsPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :events_phoenix,
    adapter: Ecto.Adapters.Postgres
end
