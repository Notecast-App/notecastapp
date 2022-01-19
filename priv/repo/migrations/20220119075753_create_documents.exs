defmodule Notecastapp.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :title, :string
      add :script, :text
      add :voice, :string
      add :filename, :string
      add :folder_id, references(:folders, on_delete: :nothing)

      timestamps()
    end
  end
end
