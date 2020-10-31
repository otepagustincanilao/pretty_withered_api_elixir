defmodule PrettyWitheredApi.Schemas.Product do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "products" do
    field :model, :string
    field :name, :string
    field :description, :string
    field :category_or_subcat, {:array, :string}
    field :taggings, {:array, :string}
    field :current_price, :decimal
    field :original_price, :decimal
    field :sku, :string
    field :stock, :integer
    field :is_featured_item, :boolean

    belongs_to(:brand, PrettyWitheredApi.Schemas.Brand, references: :code, type: :string, foreign_key: :brand_code)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :model,
      :name,
      :description, 
      :category_or_subcat, 
      :taggings, 
      :current_price, 
      :original_price, 
      :sku,
      :stock,
      :is_featured_item
    ])
  end
end
 