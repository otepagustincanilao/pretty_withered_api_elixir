defmodule PrettyWitheredApi.Contexts.Product.Create do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  alias PrettyWitheredApi.Schemas.{
    Brand,
    Category,
    SubCategory,
    Collection
  }

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}
  def validate_params(params, :graphql_mutation) do
    fields = %{
      brand_code: :string,
      collection_code: :string, ## optional
      model: :string,
      name: :string,
      description: :string,
      categories: {:array, :string},
      taggings: {:array, :string},
      current_price: :decimal,
      original_price: :decimal,
      sku: :string, 
      stock: :integer,
      is_featured_item: :boolean
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:brand_code], message: "Enter brand code")
    |> Changeset.validate_required([:model], message: "Enter model")
    |> Changeset.validate_required([:name], message: "Enter name")
    |> Changeset.validate_format(:model, ~r/^[ a-zA-Z0-9-,.]*$/, message: "Model only accepts special character dot (.), comma (,) and hyphen (-)")
    |> Changeset.validate_length(:model, max: 40, message: "Model only accepts alphanumeric value up to 40 characters")
    |> Changeset.validate_required([:current_price], message: "Enter current price")
    |> Changeset.validate_required([:original_price], message: "Enter original price")
    |> validate_collection_code()
    |> validate_category_or_subcat()
    |> is_valid_changeset?()
  end

  defp validate_collection_code(%{changes: %{collection_code: collection_code}} = changeset) do
    raise collection_code 
  end
  defp validate_collection_code(changeset), do: changeset

  ## Develop predecessor 1st
  ## Brand
  ## Collection
  ## Category
  ## Subcategory
  
  defp validate_category_or_subcat(changeset) do
    raise 3
  end

  
end