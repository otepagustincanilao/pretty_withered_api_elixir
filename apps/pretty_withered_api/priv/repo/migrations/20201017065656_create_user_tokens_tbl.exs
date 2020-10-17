defmodule PrettyWitheredApi.Repo.Migrations.CreateUserTokensTbl do
  use Ecto.Migration

 	def up do
	  create table(:user_tokens, primary_key: false) do
	    add :id, :binary_id, primary_key: true
	    add :user_id, references(:users, column: :id, type: :binary_id, on_delete: :delete_all)
	    add :token, :string
	    add :platform, :string

		timestamps()
	  end

	end

	def down do
	  drop table(:user_tokens)
	end
end
