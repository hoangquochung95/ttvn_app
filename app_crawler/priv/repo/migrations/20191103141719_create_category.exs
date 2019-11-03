defmodule AppCrawler.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_name, :string
      add :date, :string
      add :post_count, :integer

      timestamps()
    end

  end
end
