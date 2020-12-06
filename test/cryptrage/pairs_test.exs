defmodule Cryptrage.PairsTest do
  use Cryptrage.DataCase

  alias Cryptrage.Pairs

  describe "pairs" do
    alias Cryptrage.Pairs.Pair

    @valid_attrs %{asset_id: "some asset_id", name: "some name", quote: "120.5", slug: "some slug"}
    @update_attrs %{asset_id: "some updated asset_id", name: "some updated name", quote: "456.7", slug: "some updated slug"}
    @invalid_attrs %{asset_id: nil, name: nil, quote: nil, slug: nil}

    def pair_fixture(attrs \\ %{}) do
      {:ok, pair} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pairs.create_pair()

      pair
    end

    test "list_pairs/0 returns all pairs" do
      pair = pair_fixture()
      assert Pairs.list_pairs() == [pair]
    end

    test "get_pair!/1 returns the pair with given id" do
      pair = pair_fixture()
      assert Pairs.get_pair!(pair.id) == pair
    end

    test "create_pair/1 with valid data creates a pair" do
      assert {:ok, %Pair{} = pair} = Pairs.create_pair(@valid_attrs)
      assert pair.asset_id == "some asset_id"
      assert pair.name == "some name"
      assert pair.quote == Decimal.new("120.5")
      assert pair.slug == "some slug"
    end

    test "create_pair/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pairs.create_pair(@invalid_attrs)
    end

    test "update_pair/2 with valid data updates the pair" do
      pair = pair_fixture()
      assert {:ok, %Pair{} = pair} = Pairs.update_pair(pair, @update_attrs)
      assert pair.asset_id == "some updated asset_id"
      assert pair.name == "some updated name"
      assert pair.quote == Decimal.new("456.7")
      assert pair.slug == "some updated slug"
    end

    test "update_pair/2 with invalid data returns error changeset" do
      pair = pair_fixture()
      assert {:error, %Ecto.Changeset{}} = Pairs.update_pair(pair, @invalid_attrs)
      assert pair == Pairs.get_pair!(pair.id)
    end

    test "delete_pair/1 deletes the pair" do
      pair = pair_fixture()
      assert {:ok, %Pair{}} = Pairs.delete_pair(pair)
      assert_raise Ecto.NoResultsError, fn -> Pairs.get_pair!(pair.id) end
    end

    test "change_pair/1 returns a pair changeset" do
      pair = pair_fixture()
      assert %Ecto.Changeset{} = Pairs.change_pair(pair)
    end
  end
end
