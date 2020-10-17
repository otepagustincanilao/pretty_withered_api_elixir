defmodule PrettyWitheredApi.Repo.Migrations.CreateProductUserCommentsTbl do
  use Ecto.Migration

	def up do
		create table(:product_user_comments, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :product_user_rating_id, references(:product_user_ratings, column: :id, type: :binary_id, on_delete: :delete_all)
			add :comments, :text

			timestamps()
		end
	end

	def down do
		drop table(:product_user_comments)
	end
end
