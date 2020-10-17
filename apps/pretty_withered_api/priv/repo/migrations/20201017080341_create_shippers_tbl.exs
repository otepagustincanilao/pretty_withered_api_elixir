defmodule PrettyWitheredApi.Repo.Migrations.CreateShippersTbl do
  use Ecto.Migration

	def up do
		create table(:shippers, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :name, :string, size: 120
			add :description, :string, size: 40
			add :remarks, :string, size: 40

			timestamps()
		end
	end

	def down do
		drop table(:shippers)
	end
end
