defmodule Cryptrage.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
  end
end
