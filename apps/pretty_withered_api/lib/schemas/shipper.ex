defmodule PrettyWitheredApi.Schemas.Shipper do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "shippers" do
    field :name, :string
    field :description, :decimal
    field :remarks, :decimal

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :name,
      :description,
      :remarks
    ])
  end
end
 