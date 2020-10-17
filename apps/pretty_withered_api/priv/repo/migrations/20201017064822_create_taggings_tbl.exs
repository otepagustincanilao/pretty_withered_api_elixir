defmodule PrettyWitheredApi.Repo.Migrations.CreateTaggingsTbl do
  use Ecto.Migration

  def up do
	  create table(:taggings, primary_key: false) do
	    add :id, :binary_id, primary_key: true
	    add :title, :string, size: 60
	    add :description, :text
	   	add :slug, :string, size: 60

	    timestamps()
	  end

	end

	def down do
	  drop table(:taggings)
	end
end
