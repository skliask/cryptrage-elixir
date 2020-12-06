defmodule Cryptrage.Repo.Migrations.CreatePairs do
  use Ecto.Migration

  def change do
    create table(:pairs) do
      add :name, :string
      add :slug, :string
      add :asset_id, :string
      add :quote, :decimal
      add :market_id, references(:markets, on_delete: :nothing)
      add :base_id, references(:assets, on_delete: :nothing)
      add :quote_id, references(:assets, on_delete: :nothing)

      timestamps()
    end

    create index(:pairs, [:market_id])
    create index(:pairs, [:base_id])
    create index(:pairs, [:quote_id])
  end
end
