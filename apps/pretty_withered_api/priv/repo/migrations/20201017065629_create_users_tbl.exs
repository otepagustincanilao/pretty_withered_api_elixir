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
	   	add :is_verified, :boolean
	   	add :is_first_time, :boolean
	   	add :login_attempts, :integer
	   	######
	   	add :deactivate_date, :utc_datetime
	   	add :deactivate_remarks, :text
	   	add :reactivate_date, :utc_datetime
	   	add :reactivate_remarks, :text
	    timestamps()
	  end

	end

	def down do
	  drop table(:users)
	end
end
