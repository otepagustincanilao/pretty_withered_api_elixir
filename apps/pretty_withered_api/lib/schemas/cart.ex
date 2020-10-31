defmodule PrettyWitheredApi.Schemas.Cart do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "carts" do
    field :product_id, :binary_id
    field :product_variant_id, :binary_id
    field :qty, :integer
    field :remarks, :string

    belongs_to(:customer, PrettyWitheredApi.Schemas.Customer)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :product_id,
      :product_variant_id,
      :qty,
      :remarks
    ])
  end
end
