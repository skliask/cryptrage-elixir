defmodule Cryptrage.Markets.Market do
  use Ecto.Schema
  import Ecto.Changeset

  schema "markets" do
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(market, attrs) do
    market
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
  end
end
