defmodule Beepbopskeet.Admin do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias Beepbopskeet.Repo

  alias Beepbopskeet.Admin.Card

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Card{}, ...]

  """
  def list_cards do
    Repo.all(Card)
  end

  def list_socials do
    query =
      from s in "cards",
        where: s.category == "SOCIALS",
        select: %{link: s.link, title: s.title, material_icon_title: s.material_icon_title, category: s.category}

    Repo.all(query)
  end

  def list_general do
    query =
      from s in "cards",
        where: s.category == "GENERAL",
        select: %{link: s.link, title: s.title, material_icon_title: s.material_icon_title, category: s.category}

    Repo.all(query)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id)

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    card
    |> Card.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{source: %Card{}}

  """
  def change_card(%Card{} = card) do
    Card.changeset(card, %{})
  end

  alias Beepbopskeet.Admin.Announcement

  @doc """
  Returns the list of announcements.

  ## Examples

      iex> list_announcements()
      [%Announcement{}, ...]

  """
  def list_announcements do
    Repo.all(Announcement)
  end

  @doc """
  Gets a single announcement.

  Raises `Ecto.NoResultsError` if the Announcement does not exist.

  ## Examples

      iex> get_announcement!(123)
      %Announcement{}

      iex> get_announcement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_announcement!(id), do: Repo.get!(Announcement, id)

  @doc """
  Creates a announcement.

  ## Examples

      iex> create_announcement(%{field: value})
      {:ok, %Announcement{}}

      iex> create_announcement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_announcement(attrs \\ %{}) do
    %Announcement{}
    |> Announcement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a announcement.

  ## Examples

      iex> update_announcement(announcement, %{field: new_value})
      {:ok, %Announcement{}}

      iex> update_announcement(announcement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_announcement(%Announcement{} = announcement, attrs) do
    announcement
    |> Announcement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a announcement.

  ## Examples

      iex> delete_announcement(announcement)
      {:ok, %Announcement{}}

      iex> delete_announcement(announcement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_announcement(%Announcement{} = announcement) do
    Repo.delete(announcement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking announcement changes.

  ## Examples

      iex> change_announcement(announcement)
      %Ecto.Changeset{source: %Announcement{}}

  """
  def change_announcement(%Announcement{} = announcement) do
    Announcement.changeset(announcement, %{})
  end
end
