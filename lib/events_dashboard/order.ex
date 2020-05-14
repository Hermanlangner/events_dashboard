defmodule EventsDashboard.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :customer_id, :integer
    field :banking_details_id, :integer
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:customer_id, :banking_details_id])
  end
end
