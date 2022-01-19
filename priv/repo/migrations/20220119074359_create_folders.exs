defmodule Notecastapp.Repo.Migrations.CreateFolders do
  use Ecto.Migration

  def change do
    create table(:folders) do
      add :title, :string
      add :language, :boolean
      add :language_one, :string
      add :language_two, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
