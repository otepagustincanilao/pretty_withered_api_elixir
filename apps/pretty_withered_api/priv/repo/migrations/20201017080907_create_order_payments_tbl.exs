defmodule PrettyWitheredApi.Repo.Migrations.CreateOrderPaymentsTbl do
  use Ecto.Migration

	def up do
		create table(:order_payments, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :order_id, references(:orders, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :payment_method, :string, size: 5
			add :payment_amount, :decimal
			add :card_no, :string, size: 16
			add :expiry_date, :date
			add :cvv, :string, size: 5
			add :remarks, :text

			timestamps()
		end
	end

	def down do
		drop table(:order_payments)
	end
end
