defmodule Notecastapp.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :value, :text

      timestamps()
    end
  end
end
