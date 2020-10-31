defmodule PrettyWitheredApi.Schemas.BrandGallery do
  @moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "brand_galleries" do
    field :url, :string

    belongs_to(:brand, PrettyWitheredApi.Schemas.Brand, references: :code, type: :string, foreign_key: :brand_code)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :brand_code,
      :url
    ])
  end
end
