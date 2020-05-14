defmodule EventsDashboard.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :name, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
  end
end
