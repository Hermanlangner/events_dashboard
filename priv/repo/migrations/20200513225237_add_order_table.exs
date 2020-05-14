defmodule EventsDashboard.Repo.Migrations.AddOrderTable do
  use Ecto.Migration

  def change do
    create table("orders") do
      add :customer_id, :integer
      add :banking_details_id, :integer
    end
  end
end
