defmodule Discuss.Forum.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Forum.Topic


  schema "topics" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

end
