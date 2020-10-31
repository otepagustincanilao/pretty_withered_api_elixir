defmodule PrettyWitheredApi.Schemas.CustomerContact do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "customer_contacts" do
    field :type, :string
    field :number, :string
    field :country_code, :string
    field :area_code, :string
    field :local_code, :string

    belongs_to(:customer, PrettyWitheredApi.Schemas.Customer)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :customer_id,
      :type,
      :number,
      :country_code,
      :area_code,
      :local_code
    ])
  end
end
