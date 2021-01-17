defmodule PrettyWitheredApi.Repo.Migrations.CreateBrandsTbl do
  use Ecto.Migration

  	def up do
		create table(:brands, primary_key: false) do
			add :code, :string, size: 40, primary_key: true
			add :name, :string, size: 150
			add :description, :text

			timestamps()
		end
	end

	def down do
	  	drop table(:brands)
	end
end
