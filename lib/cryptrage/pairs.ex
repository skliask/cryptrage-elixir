defmodule Cryptrage.Pairs do
  @moduledoc """
  The Pairs context.
  """

  import Ecto.Query, warn: false
  alias Cryptrage.Repo

  alias Cryptrage.Pairs.Pair

  @doc """
  Returns the list of pairs.

  ## Examples

      iex> list_pairs()
      [%Pair{}, ...]

  """
  def list_pairs do
    Repo.all(Pair)
  end

  @doc """
  Gets a single pair.

  Raises `Ecto.NoResultsError` if the Pair does not exist.

  ## Examples

      iex> get_pair!(123)
      %Pair{}

      iex> get_pair!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pair!(id), do: Repo.get!(Pair, id)

  @doc """
  Creates a pair.

  ## Examples

      iex> create_pair(%{field: value})
      {:ok, %Pair{}}

      iex> create_pair(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pair(attrs \\ %{}) do
    %Pair{}
    |> Pair.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pair.

  ## Examples

      iex> update_pair(pair, %{field: new_value})
      {:ok, %Pair{}}

      iex> update_pair(pair, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pair(%Pair{} = pair, attrs) do
    pair
    |> Pair.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pair.

  ## Examples

      iex> delete_pair(pair)
      {:ok, %Pair{}}

      iex> delete_pair(pair)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pair(%Pair{} = pair) do
    Repo.delete(pair)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pair changes.

  ## Examples

      iex> change_pair(pair)
      %Ecto.Changeset{data: %Pair{}}

  """
  def change_pair(%Pair{} = pair, attrs \\ %{}) do
    Pair.changeset(pair, attrs)
  end
end
