# AppCrawler

Install elixir: https://repo.hex.pm/elixir-websetup.exe

Install nodejs https://nodejs.org/en/

Install xampp https://www.apachefriends.org/

Config server in app_crawler/config/dev.exs

Start mysql in xampp

To start your Phoenix app run in app_crawler folder:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


# Mô tả kiến trúc crawler
 
 Các bước crawler:
 
 - Vào trang localhost:4000 để chạy hàm gọi các function để crawler
 
 - Dùng HTTPpoison và Floki để lấy body dựa trên css selector của thanh menu ttvn.vn. 
 
 - Dùng a tag và attribute href để tiếp tục dùng HTTPpoison và Floki lấy body theo từng chuyên mục
 
 - Lấy thông tin của 3 bài báo đầu và các bài báo con dựa trên css selector và merge thành list đưa vào thuộc tính items của từng chuyên mục
 
 - Đếm từng post trong items để xác định post_count
 
 - Dùng Enum.map để duyệt dùng post để lấy a href và tiếp tục lấy body của từng bài post sau đó lưu vào :content của item
 
 - Dùng json encode và viết file lưu vào thư mục files
 
 - Duyệt lại categories và post để lưu vào database
