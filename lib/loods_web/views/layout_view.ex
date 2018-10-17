defmodule LoodsWeb.LayoutView do
  use LoodsWeb, :view

  def current_user_exists(conn) do
    Map.get(conn.assigns, :current_user, nil) != nil
  end
end