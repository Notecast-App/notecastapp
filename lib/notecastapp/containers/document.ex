defmodule Notecastapp.Containers.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :title, :string
    field :script, :string
    field :voice, :string
    field :filename, :string
    belongs_to :folder, Notecastapp.Container.Folder

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:title, :script, :voice, :filename])
    |> validate_required([:title, :script, :voice])
  end
end
