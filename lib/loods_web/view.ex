defmodule LoodsWeb.View do
  defmacro __using__(opts) do
    require LoodsWeb.View.Helper.PaginateView
    quote do
      def pagination_link(conn, rummage, opts \\ []) do
        PaginateView.pagination_link(
          conn,
          rummage,
          opts ++ [
            struct: struct(),
            helpers: helpers()])
      end
    end
  end
end
