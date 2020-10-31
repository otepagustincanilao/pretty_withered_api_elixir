defmodule PrettyWitheredApi.Schemas.Tagging do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "taggings" do
    field :title, :string
    field :description, :string
    field :slug, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :title,
      :description,
      :slug
    ])
  end
end
