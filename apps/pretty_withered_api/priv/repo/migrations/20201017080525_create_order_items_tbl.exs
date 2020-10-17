defmodule PrettyWitheredApi.Repo.Migrations.CreateOrderItemsTbl do
  use Ecto.Migration

	def up do
		create table(:order_items, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :order_id, references(:orders, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :product_id, :binary_id
			add :product_variant_id, :binary_id
			add :quantity, :integer
			add :unit_price, :decimal
			add :tax_price, :decimal
			add :discount, :decimal
			add :discount_type, :string, size: 10
			add :discount_remarks, :text
			add :remarks, :text

			timestamps()
		end
	end

	def down do
		drop table(:order_items)
	end
end
