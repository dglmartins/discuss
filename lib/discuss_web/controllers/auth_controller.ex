defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth
  alias Discuss.Accounts
  alias Discuss.Accounts.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params)
  do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    signin(conn, user_params)
  end

  defp signin(conn, user_params) do
    case Accounts.insert_or_update_user(user_params) do
      {:ok, %User{email: email}} ->
        conn
        |> put_flash(:info, "Hello #{email}")
        |> redirect(to: topic_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error")
        |> redirect(to: topic_path(conn, :index))
    end
  end


end
