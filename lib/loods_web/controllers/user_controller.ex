defmodule LoodsWeb.UserController do
  use LoodsWeb, :controller
  use Rummage.Phoenix.Controller

  alias Loods.Accounts
  alias Loods.Accounts.User

  def index(conn, params) do
    {page, _} = Integer.parse(Map.get(params, "page", "1"))
    sort = Map.get(params, "sort", "name")
    sort_order = if sort =~ "-" do
      :desc
    else
      :asc
    end
    sort = sort
    |> String.replace("-", "")
    |> String.to_atom()
    rummage = %{
      sort: %{
        field: sort,
        order: sort_order,
      },
      paginate: %{
        per_page: 2,
        page: page,
      },
      link_names: %{
        sort: "sort",
        paginate: "page"
      }
    }
    {users, paginator} = Accounts.filter_users(rummage)
    render(conn, "index.html", %{users: users, paginator: paginator})
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
