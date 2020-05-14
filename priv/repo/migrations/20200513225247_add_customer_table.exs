defmodule EventsDashboard.Repo.Migrations.AddCustomerTable do
  use Ecto.Migration

  def change do
    create table("customers") do
      add :customer_id, :integer
      add :name, :string
    end
  end
end
