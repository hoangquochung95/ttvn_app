defmodule AppCrawler.PostTest do
  use AppCrawler.ModelCase

  alias AppCrawler.Post

  @valid_attrs %{category_id: 42, content: "some content", origin_url: "some content", post_date: "some content", short_description: "some content", thumbnail: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
