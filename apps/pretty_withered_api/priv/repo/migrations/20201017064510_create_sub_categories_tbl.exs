defmodule PrettyWitheredApi.Repo.Migrations.CreateSubCategoriesTbl do
  use Ecto.Migration

	def up do
	  create table(:sub_categories, primary_key: false) do
	    add :id, :binary_id, primary_key: true
	    add :category_code, references(:categories, column: :code, type: :string, on_delete: :delete_all)
	    add :name, :string, size: 60
	    add :description, :text

	    timestamps()
	  end

	end

	def down do
	  drop table(:sub_categories)
	end
end
