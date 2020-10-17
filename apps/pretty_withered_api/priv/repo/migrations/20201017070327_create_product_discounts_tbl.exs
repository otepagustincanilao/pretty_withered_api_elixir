defmodule PrettyWitheredApi.Repo.Migrations.CreateProductDiscountsTbl do
  use Ecto.Migration

	def up do
		create table(:product_discounts, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :product_id, references(:products, column: :id, type: :binary_id, on_delete: :delete_all)
			add :product_variant_id, references(:product_variants, column: :id, type: :binary_id, on_delete: :delete_all)
			add :type, :string
			add :value, :decimal
			####
			add :effective_date, :datetime
			add :expiry_date, :datetime

			timestamps()
		end
	end

	def down do
		drop table(:product_discounts)
	end
end
