defmodule PrettyWitheredApi.Schemas.CustomerPaymentCard do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "customer_payment_cards" do
    field :type, :string
    field :card_no, :string
    field :expiry_date, :date

    belongs_to(:customer, PrettyWitheredApi.Schemas.Customer)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :customer_id,
      :type,
      :card_no,
      :expiry_date
    ])
  end
end
