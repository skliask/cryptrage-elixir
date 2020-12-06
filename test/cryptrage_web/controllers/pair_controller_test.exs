defmodule CryptrageWeb.PairControllerTest do
  use CryptrageWeb.ConnCase

  alias Cryptrage.Pairs

  @create_attrs %{asset_id: "some asset_id", name: "some name", quote: "120.5", slug: "some slug"}
  @update_attrs %{asset_id: "some updated asset_id", name: "some updated name", quote: "456.7", slug: "some updated slug"}
  @invalid_attrs %{asset_id: nil, name: nil, quote: nil, slug: nil}

  def fixture(:pair) do
    {:ok, pair} = Pairs.create_pair(@create_attrs)
    pair
  end

  describe "index" do
    test "lists all pairs", %{conn: conn} do
      conn = get(conn, Routes.pair_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pairs"
    end
  end

  describe "new pair" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pair_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pair"
    end
  end

  describe "create pair" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pair_path(conn, :create), pair: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pair_path(conn, :show, id)

      conn = get(conn, Routes.pair_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pair"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pair_path(conn, :create), pair: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pair"
    end
  end

  describe "edit pair" do
    setup [:create_pair]

    test "renders form for editing chosen pair", %{conn: conn, pair: pair} do
      conn = get(conn, Routes.pair_path(conn, :edit, pair))
      assert html_response(conn, 200) =~ "Edit Pair"
    end
  end

  describe "update pair" do
    setup [:create_pair]

    test "redirects when data is valid", %{conn: conn, pair: pair} do
      conn = put(conn, Routes.pair_path(conn, :update, pair), pair: @update_attrs)
      assert redirected_to(conn) == Routes.pair_path(conn, :show, pair)

      conn = get(conn, Routes.pair_path(conn, :show, pair))
      assert html_response(conn, 200) =~ "some updated asset_id"
    end

    test "renders errors when data is invalid", %{conn: conn, pair: pair} do
      conn = put(conn, Routes.pair_path(conn, :update, pair), pair: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pair"
    end
  end

  describe "delete pair" do
    setup [:create_pair]

    test "deletes chosen pair", %{conn: conn, pair: pair} do
      conn = delete(conn, Routes.pair_path(conn, :delete, pair))
      assert redirected_to(conn) == Routes.pair_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.pair_path(conn, :show, pair))
      end
    end
  end

  defp create_pair(_) do
    pair = fixture(:pair)
    %{pair: pair}
  end
end
