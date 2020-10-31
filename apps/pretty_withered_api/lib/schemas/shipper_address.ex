defmodule PrettyWitheredApi.Schemas.ShipperAddress do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "shipper_addresses" do
    field :type, :string
    field :address_line1, :string
    field :address_line2, :string
    field :city, :string
    field :province, :string
    field :region, :string
    field :postal_code, :string

    belongs_to(:shipper, PrettyWitheredApi.Schemas.Shipper)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :shipper_id,
      :type, 
      :address_line1, 
      :address_line2, 
      :city, 
      :province, 
      :region,
      :postal_code
    ])
  end
end
 