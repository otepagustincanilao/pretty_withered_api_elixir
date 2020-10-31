defmodule PrettyWitheredApi.Schemas.ProductVariant do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "product_variants" do
    field :keys, {:array, :string}
    field :values, {:array, :string}
    field :current_price, :decimal
    field :original_price, :decimal
    field :sku, :string
    field :stock, :integer

    belongs_to(:product, PrettyWitheredApi.Schemas.Product)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :product_id,
      :keys,
      :values,
      :current_price, 
      :original_price, 
      :sku,
      :stock
    ])
  end
end
 