defmodule CryptrageWeb.MarketControllerTest do
  use CryptrageWeb.ConnCase

  alias Cryptrage.Markets

  @create_attrs %{name: "some name", slug: "some slug"}
  @update_attrs %{name: "some updated name", slug: "some updated slug"}
  @invalid_attrs %{name: nil, slug: nil}

  def fixture(:market) do
    {:ok, market} = Markets.create_market(@create_attrs)
    market
  end

  describe "index" do
    test "lists all markets", %{conn: conn} do
      conn = get(conn, Routes.market_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Markets"
    end
  end

  describe "new market" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.market_path(conn, :new))
      assert html_response(conn, 200) =~ "New Market"
    end
  end

  describe "create market" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.market_path(conn, :create), market: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.market_path(conn, :show, id)

      conn = get(conn, Routes.market_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Market"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.market_path(conn, :create), market: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Market"
    end
  end

  describe "edit market" do
    setup [:create_market]

    test "renders form for editing chosen market", %{conn: conn, market: market} do
      conn = get(conn, Routes.market_path(conn, :edit, market))
      assert html_response(conn, 200) =~ "Edit Market"
    end
  end

  describe "update market" do
    setup [:create_market]

    test "redirects when data is valid", %{conn: conn, market: market} do
      conn = put(conn, Routes.market_path(conn, :update, market), market: @update_attrs)
      assert redirected_to(conn) == Routes.market_path(conn, :show, market)

      conn = get(conn, Routes.market_path(conn, :show, market))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, market: market} do
      conn = put(conn, Routes.market_path(conn, :update, market), market: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Market"
    end
  end

  describe "delete market" do
    setup [:create_market]

    test "deletes chosen market", %{conn: conn, market: market} do
      conn = delete(conn, Routes.market_path(conn, :delete, market))
      assert redirected_to(conn) == Routes.market_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.market_path(conn, :show, market))
      end
    end
  end

  defp create_market(_) do
    market = fixture(:market)
    %{market: market}
  end
end
