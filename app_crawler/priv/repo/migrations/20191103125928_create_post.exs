defmodule AppCrawler.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :post_date, :string
      add :thumbnail, :string
      add :origin_url, :string
      add :short_description, :string
      add :content, :string
      add :category_id, :integer

      timestamps()
    end

  end
end
