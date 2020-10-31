defmodule PrettyWitheredApi.Schemas.ShippingOrder do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "shipping_orders" do
    field :shipping_amount, :decimal
    field :shipping_tax_price, :decimal
    field :remarks, :string

    belongs_to(:shipper, PrettyWitheredApi.Schemas.Shipper)
    belongs_to(:order, PrettyWitheredApi.Schemas.Order)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :shipper_id,
      :order_id,
      :shipping_amount,
      :shipping_tax_price,
      :remarks
    ])
  end
end
