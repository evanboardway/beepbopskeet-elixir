defmodule Beepbopskeet.Playlists do
  @moduledoc """
  The Playlists context.
  """

  import Ecto.Query, warn: false
  alias Beepbopskeet.Repo

  alias Beepbopskeet.Playlists.Submission

  @doc """
  Returns the list of submissions.

  ## Examples

      iex> list_submissions()
      [%Submission{}, ...]

  """
  def list_submissions do
    Repo.all(Submission)
  end

  def list_incoming do
    query =
      from s in "submissions",
        where: s.status == "INCOMING",
        select: %{id: s.id, email: s.email, first_name: s.first_name, last_name: s.last_name, release_date: s.release_date, url: s.url, playlist_id: s.playlist_id, status: s.status}

    Repo.all(query)
  end

  def list_active do
    query =
      from s in "submissions",
        where: s.status == "ACTIVE",
        select: %{id: s.id, email: s.email, first_name: s.first_name, last_name: s.last_name, release_date: s.release_date, url: s.url, playlist_id: s.playlist_id, status: s.status}

    Repo.all(query)
  end

  def list_pending do
    query =
      from s in "submissions",
        where: s.status == "PENDING",
        select: %{id: s.id, email: s.email, first_name: s.first_name, last_name: s.last_name, release_date: s.release_date, url: s.url, playlist_id: s.playlist_id, status: s.status}

    Repo.all(query)
  end

  @doc """
  Gets a single submission.

  Raises `Ecto.NoResultsError` if the Submission does not exist.

  ## Examples

      iex> get_submission!(123)
      %Submission{}

      iex> get_submission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_submission!(id), do: Repo.get!(Submission, id)

  def get_submission_by_uri!(attr) do
    Repo.all(
      from s in "submissions",
        where: s.uri == ^attr,
        select: %{uri: s.uri, playlist_id: s.playlist_id}
    )
  end

  @doc """
  Creates a submission.

  ## Examples

      iex> create_submission(%{field: value})
      {:ok, %Submission{}}

      iex> create_submission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_submission(attrs \\ %{}) do
    %Submission{}
    |> Submission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a submission.

  ## Examples

      iex> update_submission(submission, %{field: new_value})
      {:ok, %Submission{}}

      iex> update_submission(submission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_submission(%Submission{} = submission, attrs) do
    submission
    |> Submission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a submission.

  ## Examples

      iex> delete_submission(submission)
      {:ok, %Submission{}}

      iex> delete_submission(submission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_submission(%Submission{} = submission) do
    Repo.delete(submission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking submission changes.

  ## Examples

      iex> change_submission(submission)
      %Ecto.Changeset{source: %Submission{}}

  """
  def change_submission(%Submission{} = submission) do
    Submission.changeset(submission, %{})
  end
end
