defmodule Notecastapp.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :value, :string

      timestamps()
    end
  end
end
