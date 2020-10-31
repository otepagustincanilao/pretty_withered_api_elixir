defmodule PrettyWitheredApi.Schemas.OrderPayment do
  @moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "order_payments" do
    field :payment_method, :string
    field :payment_amount, :decimal
    field :card_no, :string
    field :expiry_date, :date
    field :cvv, :string
    field :remarks, :string

    belongs_to(:order, PrettyWitheredApi.Schemas.Order)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :payment_method,
      :payment_amount, 
      :card_no, 
      :expiry_date, 
      :cvv, 
      :remarks
    ])
  end
end
