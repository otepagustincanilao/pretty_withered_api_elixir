defmodule PrettyWitheredApi.Repo.Migrations.CreateCustomerContactsTbl do
  use Ecto.Migration

  	def up do
		create table(:customer_contacts, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :customer_id, references(:customers, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :type, :string, size: 10
			add :number, :string, size: 20
			add :country_code, :string, size: 5
			add :area_code, :string, size: 5
			add :local_code, :string, size: 5

			timestamps()
		end
	end

	def down do
		drop table(:customer_contacts)
	end
end
