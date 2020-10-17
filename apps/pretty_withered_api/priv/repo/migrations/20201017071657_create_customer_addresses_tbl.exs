defmodule PrettyWitheredApi.Repo.Migrations.CreateCustomerAddressesTbl do
  use Ecto.Migration

	def up do
		create table(:customer_addresses, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :customer_id, references(:customers, column: :id, type: :binary_id, on_delete: :delete_all)	
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
		drop table(:customer_addresses)
	end
end
