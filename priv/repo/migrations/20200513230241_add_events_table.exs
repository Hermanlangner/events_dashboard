defmodule EventsDashboard.Repo.Migrations.AddEventsTable do
  use Ecto.Migration

  def change do
    create table("events") do
      add :order_updated, :boolean
      add :banking_details_updated, :boolean
      add :customer_updated, :boolean
    end
  end
end
