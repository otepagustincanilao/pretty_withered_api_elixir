defmodule PrettyWitheredApi.Repo.Migrations.CreateCategoriesTbl do
  use Ecto.Migration

	def up do
	  create table(:categories, primary_key: false) do
	    add :code, :string, size: 60, primary_key: true
	    add :name, :string, size: 150
	    add :description, :text
	   	add :slug, :string, size: 150

	    timestamps()
	  end

	end

	def down do
	  drop table(:categories)
	end

end
