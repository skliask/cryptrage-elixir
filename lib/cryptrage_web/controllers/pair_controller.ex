defmodule CryptrageWeb.PairController do
  use CryptrageWeb, :controller

  alias Cryptrage.Pairs
  alias Cryptrage.Pairs.Pair

  def index(conn, _params) do
    pairs = Pairs.list_pairs()
    render(conn, "index.html", pairs: pairs)
  end

  def new(conn, _params) do
    changeset = Pairs.change_pair(%Pair{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pair" => pair_params}) do
    case Pairs.create_pair(pair_params) do
      {:ok, pair} ->
        conn
        |> put_flash(:info, "Pair created successfully.")
        |> redirect(to: Routes.pair_path(conn, :show, pair))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pair = Pairs.get_pair!(id)
    render(conn, "show.html", pair: pair)
  end

  def edit(conn, %{"id" => id}) do
    pair = Pairs.get_pair!(id)
    changeset = Pairs.change_pair(pair)
    render(conn, "edit.html", pair: pair, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pair" => pair_params}) do
    pair = Pairs.get_pair!(id)

    case Pairs.update_pair(pair, pair_params) do
      {:ok, pair} ->
        conn
        |> put_flash(:info, "Pair updated successfully.")
        |> redirect(to: Routes.pair_path(conn, :show, pair))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pair: pair, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pair = Pairs.get_pair!(id)
    {:ok, _pair} = Pairs.delete_pair(pair)

    conn
    |> put_flash(:info, "Pair deleted successfully.")
    |> redirect(to: Routes.pair_path(conn, :index))
  end
end
