defmodule LoodsWeb.UserView do
  use LoodsWeb, :view
  use Rummage.Phoenix.View, helpers: LoodsWeb.Router.Helpers, struct: user
end
