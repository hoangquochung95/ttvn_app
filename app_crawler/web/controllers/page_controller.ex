defmodule AppCrawler.PageController do
  use AppCrawler.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
