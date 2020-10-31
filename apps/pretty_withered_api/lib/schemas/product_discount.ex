defmodule PrettyWitheredApi.Schemas.ProductDiscount do
  @moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "product_discounts" do
    field :type, :string
    field :value, :string
    field :effective_date, :utc_datetime
    field :expiry_date, :utc_datetime

    belongs_to(:product, PrettyWitheredApi.Schemas.Product)
    belongs_to(:product_variant, PrettyWitheredApi.Schemas.ProductVariant)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :product_id,
      :product_variant_id,
      :type,
      :value,
      :effective_date, 
      :expiry_date
    ])
  end
end
 