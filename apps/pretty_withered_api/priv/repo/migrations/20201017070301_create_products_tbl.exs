defmodule PrettyWitheredApi.Repo.Migrations.CreateProductsTbl do
  use Ecto.Migration

	def up do
		create table(:products, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :brand_code, references(:brands, column: :code, type: :string, on_delete: :delete_all)
			add :collection_code, references(:collections, column: :code, type: :string, on_delete: :delete_all, null: true)
			add :model, :string, size: 40
			add :name, :string
			add :description, :text
			add :category_or_subcat, {:array, :string}
			add :taggings, {:array, :string}
			add :current_price, :decimal
			add :original_price, :decimal
			add :sku, :string
			add :stock, :int
			add :is_featured_item, :boolean

			timestamps()
		end
	end

	def down do
		drop table(:products)
	end
end
