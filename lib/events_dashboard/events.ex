defmodule EventsDashboard.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :order_updated, :boolean, default: false
    field :banking_details_updated, :boolean, default: false
    field :customer_updated, :boolean, default: false
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:order_updated, :banking_details_updated, :customer_updated])
  end
end
