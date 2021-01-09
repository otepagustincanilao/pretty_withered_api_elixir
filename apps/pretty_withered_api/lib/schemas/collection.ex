defmodule PrettyWitheredApi.Schemas.Collection do
	use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:code, :string, []}
  schema "collections" do
		field :name, :string
		field :description, :string
    field :is_active, :boolean, default: true

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code, 
			:name,
			:description,
      :is_active
    ])
  end

end
