defmodule EventsDashboard.Repo do
  use Ecto.Repo,
    otp_app: :events_dashboard,
    adapter: Ecto.Adapters.Postgres
end
