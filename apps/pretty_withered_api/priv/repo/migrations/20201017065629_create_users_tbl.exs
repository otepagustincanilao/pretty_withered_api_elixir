defmodule PrettyWitheredApi.Repo.Migrations.CreateUsersTbl do
  use Ecto.Migration

	def up do
	  create table(:users, primary_key: false) do
	    add :id, :binary_id, primary_key: true
	    add :username, :string
	    add :hashed_password, :string
	   	add :email, :string
	   	add :mobile, :string
	   	#####
	   	add :is_verified, :boolean, default: false
	   	add :is_first_time, :boolean, default: true
	   	add :login_attempts, :integer
	   	######
	   	add :deactivate_date, :utc_datetime
	   	add :deactivate_remarks, :text
	   	add :reactivate_date, :utc_datetime
	   	add :reactivate_remarks, :text

	   	add :status, :string ## asof 11/17/2020 10pm
	    timestamps()
	  end

	  create unique_index(:users, [:email])
	  create unique_index(:users, [:username])

	end

	def down do
	  drop table(:users)
	end
end
