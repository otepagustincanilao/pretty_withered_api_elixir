defmodule PrettyWitheredApi.Schemas.OrderItem do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "order_items" do
    field :product_id, :binary_id
    field :product_variant_id, :binary_id
    ##
    field :quantity, :integer
    field :unit_price, :decimal
    field :tax_price, :decimal
    field :discount, :decimal
    field :discount_type, :string
    field :discount_remarks, :string
    field :remarks, :string

    belongs_to(:order, PrettyWitheredApi.Schemas.Order)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :product_id,
      :product_variant_id,
      :order_id,
      :quantity, 
      :unit_price, 
      :tax_price, 
      :discount, 
      :discount_type,
      :discount_remarks,
      :remarks
    ])
  end
end
