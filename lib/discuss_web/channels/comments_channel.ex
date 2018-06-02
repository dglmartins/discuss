defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.Forum.{Topic, Comment}
  alias Discuss.Repo


  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)

    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => content}, socket) do
    topic_id = socket.assigns.topic.id
    user_id = socket.assigns.user_id
    IO.puts("++++++++++")


    changeset = %Comment{}
    |> Comment.changeset(%{content: content})
    |> Ecto.Changeset.put_change(:user_id, user_id)
    |> Ecto.Changeset.put_change(:topic_id, topic_id)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        comment = Repo.preload(comment, :user)

        broadcast!(
          socket, "comments:#{socket.assigns.topic.id}:new",
          %{comment: comment}
        )
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end

    # IO.inspect changeset
    # {:reply, :ok, socket}
    #
    # case Repo.insert(changeset) do
    #   {:ok, comment} ->
    #     broadcast!(
    #       socket, "comments:#{socket.assigns.topic.id}:new",
    #       %{comment: comment}
    #     )
    #     {:reply, :ok, socket}
    #   {:error, _reason} ->
    #     {:reply, {:error, %{errors: changeset}}, socket}
    # end

  end
end
