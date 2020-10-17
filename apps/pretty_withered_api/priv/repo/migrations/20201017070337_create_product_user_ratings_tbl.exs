defmodule PrettyWitheredApi.Repo.Migrations.CreateProductUserRatingsTbl do
  use Ecto.Migration

	def up do
		create table(:product_user_ratings, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :product_id, references(:products, column: :id, type: :binary_id, on_delete: :delete_all)
			add :product_variant_id, references(:product_variants, column: :id, type: :binary_id, on_delete: :delete_all)
			add :user_id, references(:users, column: :id, type: :binary_id, on_delete: :delete_all)
			add :ratings, :integer

			timestamps()
		end
	end

	def down do
		drop table(:product_user_ratings)
	end
end
