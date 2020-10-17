defmodule PrettyWitheredApi.Repo.Migrations.CreateCustomersTbl do
  use Ecto.Migration

	def up do
		create table(:customers, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :user_id, references(:users, column: :id, type: :binary_id, on_delete: :delete_all)
			add :first_name, :string, size: 40
			add :middle_name, :string, size: 40
			add :last_name, :string, size: 40
			add :suffix, :string, size: 10
			add :birth_date, :date
			add :gender, :string, size: 2

			timestamps()
		end
	end

	def down do
		drop table(:customers)
	end
end
