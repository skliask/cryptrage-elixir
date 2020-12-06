defmodule CryptrageWeb.MarketController do
  use CryptrageWeb, :controller

  alias Cryptrage.Markets
  alias Cryptrage.Markets.Market

  def index(conn, _params) do
    markets = Markets.list_markets()
    render(conn, "index.html", markets: markets)
  end

  def new(conn, _params) do
    changeset = Markets.change_market(%Market{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"market" => market_params}) do
    case Markets.create_market(market_params) do
      {:ok, market} ->
        conn
        |> put_flash(:info, "Market created successfully.")
        |> redirect(to: Routes.market_path(conn, :show, market))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    market = Markets.get_market!(id)
    render(conn, "show.html", market: market)
  end

  def edit(conn, %{"id" => id}) do
    market = Markets.get_market!(id)
    changeset = Markets.change_market(market)
    render(conn, "edit.html", market: market, changeset: changeset)
  end

  def update(conn, %{"id" => id, "market" => market_params}) do
    market = Markets.get_market!(id)

    case Markets.update_market(market, market_params) do
      {:ok, market} ->
        conn
        |> put_flash(:info, "Market updated successfully.")
        |> redirect(to: Routes.market_path(conn, :show, market))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", market: market, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    market = Markets.get_market!(id)
    {:ok, _market} = Markets.delete_market(market)

    conn
    |> put_flash(:info, "Market deleted successfully.")
    |> redirect(to: Routes.market_path(conn, :index))
  end
end
