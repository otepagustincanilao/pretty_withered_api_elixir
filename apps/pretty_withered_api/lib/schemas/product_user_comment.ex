defmodule PrettyWitheredApi.Schemas.ProductUserComment do
  @moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "product_user_comments" do
    field :comments, :string

    belongs_to(:product_user_rating, PrettyWitheredApi.Schemas.ProductUserRating)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :product_user_rating_id,
      :comments
    ])
  end
end
 