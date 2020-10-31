defmodule PrettyWitheredApi.Schemas.Category do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:code, :string, []}
  schema "categories" do
    field :name, :string
    field :description, :string
    field :slug, :string

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
