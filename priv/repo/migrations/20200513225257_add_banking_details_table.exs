defmodule EventsDashboard.Repo.Migrations.AddBankingDetailsTable do
  use Ecto.Migration

  def change do
    create table("banking_details") do
      add :customer_id, :integer
      add :account_number, :integer
    end
  end
end
