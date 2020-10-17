defmodule PrettyWitheredApi.Repo.Migrations.CreateShipperAddressesTbl do
  use Ecto.Migration

	def up do
		create table(:shipper_addresses, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :shipper_id, references(:shippers, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :type, :string, size: 30
			add :address_line1, :string, size: 40
			add :address_line2, :string, size: 40
			add :city, :string, size: 40
			add :province, :string, size: 40
			add :region, :string, size: 40
			add :postal_code, :string, size: 40

			timestamps()
		end
	end

	def down do
		drop table(:shipper_addresses)
	end
end
