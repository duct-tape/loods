defmodule LoodsWeb.SessionController do
  use LoodsWeb, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  alias Loods.Accounts
  alias Loods.Accounts.User
  alias Loods.Guardian

  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => username,
                                    "password" => password}}) do

    # try to get user by unique email from DB
    user = Accounts.get_user_by(username: username)
    # examine the result
    result = cond do
      # if user was found and provided password hash equals to stored
      # hash
      user && checkpw(password, user.password) ->
        {:ok, login(conn, user)}
        # else if we just found the use
        user ->
        {:error, :unauthorized, conn}
        # otherwise
        true ->
        # simulate check password hash timing
        dummy_checkpw
        {:error, :not_found, conn}
    end
    case result do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You’re now logged in!")
        |> redirect(to: user_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  defp login(conn, user) do
    Guardian.Plug.sign_in(conn, user)
  end

  def show(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "See you later!")
    |> redirect(to: page_path(conn, :index))
  end
end
