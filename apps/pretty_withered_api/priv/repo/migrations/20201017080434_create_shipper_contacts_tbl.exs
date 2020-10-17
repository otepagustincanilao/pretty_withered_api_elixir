defmodule PrettyWitheredApi.Repo.Migrations.CreateShipperContactsTbl do
  use Ecto.Migration

	def up do
		create table(:shipper_contacts, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :shipper_id, references(:shippers, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :type, :string, size: 10
			add :number, :string, size: 20
			add :country_code, :string, size: 5
			add :area_code, :string, size: 5
			add :local_code, :string, size: 5

			timestamps()
		end
	end

	def down do
		drop table(:shipper_contacts)
	end
end
