defmodule AppCrawler.Category do
  use AppCrawler.Web, :model

  schema "categories" do
    field :category_name, :string
    field :date, :string
    field :post_count, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:category_name, :date, :post_count])
    |> validate_required([:category_name, :date, :post_count])
  end
end
