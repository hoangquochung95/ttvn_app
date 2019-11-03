defmodule AppCrawler.CategoryTest do
  use AppCrawler.ModelCase

  alias AppCrawler.Category

  @valid_attrs %{category_name: "some content", date: "some content", post_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end
end
