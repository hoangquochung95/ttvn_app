defmodule AppCrawler.Post do
  use AppCrawler.Web, :model

  schema "posts" do
    field :title, :string
    field :post_date, :string
    field :thumbnail, :string
    field :origin_url, :string
    field :short_description, :string
    field :content, :string
    field :category_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :post_date, :thumbnail, :origin_url, :short_description, :content, :category_id])
    |> validate_required([:title, :post_date, :thumbnail, :origin_url, :short_description, :content, :category_id])
  end
end
