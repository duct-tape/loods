defmodule LoodsWeb.ItemController do
  use LoodsWeb, :controller
  use Rummage.Phoenix.Controller

  alias Loods.Rummage
  alias Loods.Parts
  alias Loods.Parts.Item

  def index(conn, params) do
    rummage = Rummage.convert_params(params)
    {items, paginator} = Parts.filter_items(rummage)
    render(conn, "index.html", %{items: items, paginator: paginator})
  end

  def new(conn, _params) do
    changeset = Parts.change_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    case Parts.create_item(item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: item_path(conn, :show, item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Parts.get_item!(id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Parts.get_item!(id)
    changeset = Parts.change_item(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Parts.get_item!(id)

    case Parts.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: item_path(conn, :show, item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Parts.get_item!(id)
    {:ok, _item} = Parts.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: item_path(conn, :index))
  end
end
