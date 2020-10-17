defmodule PrettyWitheredApi.Repo.Migrations.CreateLookUpsTbl do
  use Ecto.Migration

	def up do
		create table(:look_ups, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :type, :string
			add :code, :string
			add :name, :string
			add :description, :text

			timestamps()
		end
	end

	def down do
	  	drop table(:look_ups)
	end
end
