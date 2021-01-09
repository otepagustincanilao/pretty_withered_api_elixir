defmodule PrettyWitheredApi.Repo.Migrations.CreateCollectionsTbl do
  use Ecto.Migration

	def up do
		create table(:collections, primary_key: false) do
			add :code, :string, size: 20, primary_key: true
			add :name, :string, size: 60
			add :description, :text
			add :is_active, :boolean, default: true

			timestamps()
		end
	end

	def down do
	  	drop table(:collections)
	end
end
