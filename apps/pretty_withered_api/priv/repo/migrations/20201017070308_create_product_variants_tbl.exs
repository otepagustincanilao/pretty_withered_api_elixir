defmodule PrettyWitheredApi.Repo.Migrations.CreateProductVariantsTbl do
  use Ecto.Migration

	def up do
		create table(:product_variants, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :product_id, references(:products, column: :id, type: :binary_id, on_delete: :delete_all)
			add :keys, {:array, :string}
			add :values, {:array, :string}
			add :current_price, :decimal
			add :original_price, :decimal
			add :sku, :string
			add :stock, :int
			add :image, :string

			timestamps()
		end
	end

	def down do
		drop table(:product_variants)
	end
end
