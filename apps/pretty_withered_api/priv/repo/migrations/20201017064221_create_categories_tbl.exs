defmodule PrettyWitheredApi.Repo.Migrations.CreateCategoriesTbl do
  use Ecto.Migration

	def up do
	  create table(:categories, primary_key: false) do
	    add :code, :string, size: 20, primary_key: true
	    add :name, :string, size: 60
	    add :description, :text
	   	add :slug, :string, size: 60

	    timestamps()
	  end

	end

	def down do
	  drop table(:categories)
	end

end
