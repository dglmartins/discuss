defmodule Discuss.Forum do
  @moduledoc """
  The Forum context.
  """

  import Ecto.Query, warn: false
  alias Discuss.Repo
  alias Discuss.Forum.Topic

  @doc """
  Returns the list of topic.

  ## Examples

      iex> list_topic()
      [%Topic{}, ...]

  """
  def list_topic do
    Repo.all(Topic)
  end

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end
end
