defmodule AppCrawler.CategoryHelper do
    alias AppCrawler.Repo
    alias AppCrawler.Category
    alias AppCrawler.Post

    def get_categories() do
      Repo.all( Category)
    end

    def insert(category) do
      %Category{}
      |> Category.changeset(category)
      |> Repo.insert()
    end

    def insert_post(post) do
      %Post{}
      |> Post.changeset(post)
      |> Repo.insert()
    end
end
