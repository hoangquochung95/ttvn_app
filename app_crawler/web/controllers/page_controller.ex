defmodule AppCrawler.PageController do
  use AppCrawler.Web, :controller

  def index(conn, _params) do
    all_links = get_content("http://ttvn.vn", max_depth: 1)
    render conn, "index.html"
  end
end
