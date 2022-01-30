defmodule Notecastapp.Repo.Migrations.FixTokenTable do
  use Ecto.Migration

  def change do
    alter table(:tokens) do
      modify :value, :text
    end
  end
end
