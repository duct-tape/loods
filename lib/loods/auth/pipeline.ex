defmodule Loods.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :loods,
    error_handler: Loods.Auth.ErrorHandler,
    module: Loods.Guardian

  plug Guardian.Plug.VerifySession

  plug Guardian.Plug.EnsureAuthenticated

  plug Guardian.Plug.LoadResource
end
