defmodule PrettyWitheredApi.Repo.Migrations.CreateBrandGalleriesTbl do
  use Ecto.Migration

	def up do
	  create table(:brand_galleries, primary_key: false) do
	    add :id, :binary_id, primary_key: true
	    add :brand_code, references(:brands, column: :code, type: :string, on_delete: :delete_all)
	    add :url, :text

	    timestamps()
	  end

	end

	def down do
	  drop table(:brand_galleries)
	end
end
