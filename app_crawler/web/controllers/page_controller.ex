defmodule AppCrawler.PageController do
  use AppCrawler.Web, :controller

  def index(conn, _params) do
    all_links = get_links("http://ttvn.vn", max_depth: 2)
    category = separate_functions(all_links)

    render conn, "index.html"
  end
end
