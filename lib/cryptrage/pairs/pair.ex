defmodule Cryptrage.Pairs.Pair do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pairs" do
    field :asset_id, :string
    field :name, :string
    field :quote, :decimal
    field :slug, :string
    field :market_id, :id
    field :base_id, :id
    field :quote_id, :id

    timestamps()
  end

  @doc false
  def changeset(pair, attrs) do
    pair
    |> cast(attrs, [:name, :slug, :asset_id, :quote])
    |> validate_required([:name, :slug, :asset_id, :quote])
  end
end
