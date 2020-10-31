defmodule PrettyWitheredApi.Schemas.SubCategory do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:code, :string, []}
  schema "sub_categories" do
    field :name, :string
    field :description, :string
    field :slug, :string

    belongs_to(:category, PrettyWitheredApi.Schemas.Category, references: :code, type: :string, foreign_key: :category_code)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code,
      :name,
      :description,
      :slug
    ])
  end
end
