defmodule LoodsWeb.Router do
  use LoodsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Loods.Auth.CurrentUser
  end

  pipeline :with_session do
    plug Loods.Auth.Pipeline
    plug Loods.Auth.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LoodsWeb do
    pipe_through :browser

    get "/", PageController, :index

    # get "/register", UserController, :new
    # post "/register", UserController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", LoodsWeb do

    pipe_through [:browser, :with_session]
    resources "/users", UserController
    get "/logout", SessionController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", LoodsWeb do
  #   pipe_through :api
  # end
end
