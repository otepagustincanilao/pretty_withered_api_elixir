defmodule PrettyWitheredApi.Schemas.ProductUserRating do
  @moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "product_user_ratings" do
    field :ratings, :integer

    belongs_to(:product, PrettyWitheredApi.Schemas.Product)
    belongs_to(:product_variant, PrettyWitheredApi.Schemas.ProductVariant)
    belongs_to(:user, PrettyWitheredApi.Schemas.User)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :product_id,
      :product_variant_id,
      :user_id,
      :ratings
    ])
  end
end
 