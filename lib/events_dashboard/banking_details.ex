defmodule EventsDashboard.BankingDetails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "banking_details" do
    field :customer_id, :integer
    field :account_number, :integer
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:account_number, :customer_id])
  end
end
