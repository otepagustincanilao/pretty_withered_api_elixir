defmodule PrettyWitheredApi.Schemas.Order do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "orders" do
    field :order_no, :string
    field :total_price, :decimal
    field :total_tax_price, :decimal
    field :total_discounted_amount, :decimal
    field :shipping_price, :decimal
    field :shipping_tax_price, :decimal
    field :remarks, :string
    field :status, :string

    belongs_to(:customer, PrettyWitheredApi.Schemas.Customer)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :customer_id,
      :order_no,
      :total_price, 
      :total_tax_price, 
      :total_discounted_amount, 
      :shipping_price, 
      :shipping_tax_price, 
      :remarks,
      :status
    ])
  end
end
 