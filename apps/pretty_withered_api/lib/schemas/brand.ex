defmodule PrettyWitheredApi.Schemas.Brand do
	use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:code, :string, []}
  schema "brands" do
		field :name, :string
		field :description, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code, 
			:name,
			:description
    ])
  end

end
