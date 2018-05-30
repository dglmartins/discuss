defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Forum
  alias Discuss.Forum.Topic

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Forum.list_topic()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    case Forum.create_topic(conn.assigns.user, topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    topic = Forum.get_topic!(id)
    changeset = Forum.change_topic(topic)
    render(conn, "edit.html", topic: topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Forum.get_topic!(id)

    case Forum.update_topic(topic, topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic successfully saved")
        |> redirect(to: topic_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Forum.get_topic!(id)
    {:ok, _topic} = Forum.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: topic_path(conn, :index))
  end

end
