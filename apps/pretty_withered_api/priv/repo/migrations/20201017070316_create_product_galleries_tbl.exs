defmodule PrettyWitheredApi.Repo.Migrations.CreateProductGalleriesTbl do
  use Ecto.Migration

	def up do
		create table(:product_galleries, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :product_id, references(:products, column: :id, type: :binary_id, on_delete: :delete_all)
			add :product_variant_id, references(:product_variants, column: :id, type: :binary_id, on_delete: :delete_all)
			add :type, :string
			add :url, :text

			timestamps()
		end
	end

	def down do
		drop table(:product_galleries)
	end
end
