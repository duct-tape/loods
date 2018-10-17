defmodule LoodsWeb.PageController do
  use LoodsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
