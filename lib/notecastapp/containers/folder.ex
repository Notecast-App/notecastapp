defmodule Notecastapp.Containers.Folder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "folders" do
    field :title, :string
    field :language, :boolean
    field :language_one, :string
    field :language_two, :string
    belongs_to :user, Notecastapp.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:title, :language, :language_one, :language_two])
    |> validate_required([:title, :language])
  end
end
