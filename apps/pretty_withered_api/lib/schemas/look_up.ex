defmodule PrettyWitheredApi.Schemas.LookUp do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "look_ups" do
    field :type, :string
    field :code, :string
    field :name, :string
    field :description, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :type,
      :code,
      :name,
      :description
    ])
  end
end
