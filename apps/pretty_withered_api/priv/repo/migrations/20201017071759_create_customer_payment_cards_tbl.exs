defmodule PrettyWitheredApi.Repo.Migrations.CreateCustomerPaymentCardsTbl do
  use Ecto.Migration

	def up do
		create table(:customer_payment_cards, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :customer_id, references(:customers, column: :id, type: :binary_id, on_delete: :delete_all)	
			add :type, :string, size: 15
			add :card_no, :string, size: 16
			add :expiry_date, :date

			timestamps()
		end
	end

	def down do
		drop table(:customer_payment_cards)
	end
end
