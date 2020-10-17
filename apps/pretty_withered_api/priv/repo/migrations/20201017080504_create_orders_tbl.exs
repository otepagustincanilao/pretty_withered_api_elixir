defmodule PrettyWitheredApi.Repo.Migrations.CreateOrdersTbl do
  use Ecto.Migration

	def up do
		create table(:orders, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :customer_id, references(:customers, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :order_no, :string, size: 40
			add :total_price, :decimal
			add :total_tax_price, :decimal
			add :total_discounted_amount, :decimal
			add :shipping_price, :decimal
			add :shipping_tax_price, :decimal
			add :remarks, :text
			add :status, :string, size: 5

			timestamps()
		end
	end

	def down do
		drop table(:orders)
	end
end
