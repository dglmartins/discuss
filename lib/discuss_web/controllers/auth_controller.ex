defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth
  alias Discuss.Accounts

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params)
  do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    signin(conn, user_params)
  end

  def signout(conn, _params) do
    conn
    |> put_flash(:info, "Signed out")
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))
  end

  defp signin(conn, user_params) do
    case Accounts.insert_or_update_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back")
        |> redirect(to: topic_path(conn, :index))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, "Error")
        |> redirect(to: topic_path(conn, :index))
    end
  end




end
