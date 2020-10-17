defmodule PrettyWitheredApi.Repo.Migrations.CreateShippingOrdersTbl do
  use Ecto.Migration

	def up do
		create table(:shipping_orders, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :order_id, references(:orders, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :shipping_id, references(:shippers, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :shipping_amount, :decimal
			add :shipping_tax_price, :decimal
			add :remarks, :text

			timestamps()
		end
	end

	def down do
		drop table(:shipping_orders)
	end
end
