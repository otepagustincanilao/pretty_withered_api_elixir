defmodule PrettyWitheredApi.Schemas.ShipperContact do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "shipper_contacts" do
    field :type, :string
    field :number, :string
    field :country_code, :string
    field :area_code, :string
    field :local_code, :string

    belongs_to(:shipper, PrettyWitheredApi.Schemas.Shipper)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :shipper_id,
      :type,
      :number,
      :country_code,
      :area_code,
      :local_code
    ])
  end
end
