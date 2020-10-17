defmodule PrettyWitheredApi.Repo.Migrations.CreateCartsTbl do
  use Ecto.Migration

	def up do
		create table(:carts, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :customer_id, references(:customers, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :product_id, :binary_id
			add :product_variant_id, :binary_id
			add :qty, :integer
			add :remarks, :text

			timestamps()
		end
	end

	def down do
		drop table(:carts)
	end
end
