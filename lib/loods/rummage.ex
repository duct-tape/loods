defmodule Loods.Rummage do
  def convert_params(params) do
    {page, _} = Integer.parse(Map.get(params, "page", "1"))
    {per_page, _} = Integer.parse(Map.get(params, "per_page", "10"))
    sort = Map.get(params, "sort", "-id")
    sort_order = if sort =~ "-" do
      :desc
    else
      :asc
    end
    sort = sort
    |> String.replace("-", "")
    |> String.to_atom()

    %{
      sort: %{
        field: sort,
        order: sort_order,
      },
      paginate: %{
        per_page: per_page,
        page: page,
      },
      link_names: %{
        sort: "sort",
        paginate: %{
          page: "page",
          per_page: "per_page"
        }
      }
    }
  end
end
