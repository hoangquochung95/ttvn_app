defmodule AppCrawler.Crawler do
  @default_max_depth 3
  @default_headers []
  @default_options [follow_redirect: true]

  def get_content(url, opts \\ []) do
    url = URI.parse(url)

    context = %{
      max_depth: Keyword.get(opts, :max_depth, @default_max_depth),
      headers: Keyword.get(opts, :headers, @default_headers),
      options: Keyword.get(opts, :options, @default_options),
      host: url.host,
      timeout: 50000,
      recv_timeout: 50000
    }

    get_body(url, context)
    |> get_category_links(url, context)
    # |> Enum.map(&IO.inspect/1)
    # |> Enum.map(&to_string/1)
    # |> Enum.uniq()
    # |> Enum.map(&(get_links_post(&1,context)))
  end

  defp get_body(url, context) do
    url
    |> to_string
    |> HTTPoison.get(context.headers, context.options)

  end

  defp get_category_links({:ok, %{body: body}}, url, context) do
    body
        |> Floki.find("#menu_wrap li:not(.icon_menu_right):not(.bt_home) a")
        |> Floki.attribute("href")
        |> Enum.map(&URI.merge(url, &1))
        |> Enum.map(&to_string/1)
        |> Enum.map(&get_body(&1, context))
        |> Enum.map(fn {_, result} -> result.body end)
        |> Enum.map(fn body ->
            %{
              :category_name => get_category_name(body),
              :date => Date.to_string(Date.utc_today()),
              :post_count => 0,
              :items => get_main_posts(body,url) |> List.flatten()
            }
        end)
        |> Enum.map(&( %{ &1 | post_count: Enum.count(&1[:items])}))
        |> Enum.map(fn item ->
          item[:items]
            |> Enum.map(&get_body_post(&1[:origin_url], context))
        end)
        # |> Enum.map(&IO.inspect/1)
        # |> Enum.map(&(create_info()))
        # |> List.flatten()
  end

  defp get_category_name(body) do
    body
      |> Floki.find("h1.zone-title a")
      |> Floki.attribute("title")
      |> Enum.map(&to_string/1)
  end

  defp get_category_items(body,url) do
    [
      get_first_main_post(body,url)
    ]
  end

  defp get_main_posts(body,url) do
    [
      get_first_main_post(body,url)
      | [ get_two_submain_posts(body,url)
      | get_list_child_posts(body,url) ]
    ]
  end
  defp get_first_main_post(body,url) do
    %{
      :title => body |> Floki.find("div.firstitem .hl-info h2 a") |> Floki.text(),
      :post_date => body |> Floki.find("div.firstitem .hl-info p.time") |> Floki.text(),
      :thumbnail => body |> Floki.find("div.firstitem a.avatar img") |> Floki.attribute("src"),
      :origin_url => body |> Floki.find("div.firstitem a.avatar")
                          |> Floki.attribute("href")
                          |> Enum.map(&URI.merge(url, &1))
                          |> Enum.map(&to_string/1)
                          |> Enum.at(0),
      :short_description => body |> Floki.find("div.firstitem .hl-info .sapo") |> Floki.text()
    }
  end

  defp get_two_submain_posts(body,url) do
    body
      |> Floki.find(".cate-hl-row2 li.big")
      |> Enum.map(fn part_html ->
        %{
          :title => part_html |> Floki.find("h3 a") |> Floki.text(),
          :post_date => part_html |> Floki.find("p.time") |> Floki.text(),
          :thumbnail => part_html |> Floki.find("h3 a img") |> Floki.attribute("src"),
          :origin_url => part_html |> Floki.find("h3 a")
                              |> Floki.attribute("href")
                              |> Enum.map(&URI.merge(url, &1))
                              |> Enum.map(&to_string/1)
                              |> Enum.at(0),
          :short_description => ""
        }
      end)
  end

  defp get_list_child_posts(body,url) do
    body
      |> Floki.find(".top5_news li.tlitem")
      |> Enum.map(fn part_html ->
        %{
          :title => part_html |> Floki.find("h3 a") |> Floki.text(),
          :post_date => part_html |> Floki.find(".time") |> Floki.text(),
          :thumbnail => part_html |> Floki.find("a img") |> Floki.attribute("src"),
          :origin_url => part_html |> Floki.find("h3 a")
                              |> Floki.attribute("href")
                              |> Enum.map(&URI.merge(url, &1))
                              |> Enum.map(&to_string/1)
                              |> Enum.at(0),
          :short_description => part_html |> Floki.find("p.sapo") |> Floki.text()
        }
      end)
  end

  defp get_body_post(url, context) do
    if url !== nil do
      url = URI.parse(url)
      url
        |> get_body(context)
        |> get_content_post()
   end
  end

  defp get_content_post({:ok, %{body: body}}) do
    head_post = body
      |> Floki.find(".totalcontentdetail h2.sapo")
      |> Floki.text()
    detail_post = body
      |> Floki.find(".totalcontentdetail .contentdetail p:not(.source)")
      |> Floki.text()

      head_post <> " " <> detail_post
  end

end
