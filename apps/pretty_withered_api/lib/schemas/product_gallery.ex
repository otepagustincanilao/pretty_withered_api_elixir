defmodule PrettyWitheredApi.Schemas.ProductGallery do
  @moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "product_galleries" do
    field :type, :string
    field :url, :string

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
      :url
    ])
  end
end
 