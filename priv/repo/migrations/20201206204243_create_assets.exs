defmodule Cryptrage.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :name, :string
      add :slug, :string

      timestamps()
    end

  end
end
