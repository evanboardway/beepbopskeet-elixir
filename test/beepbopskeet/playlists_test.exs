defmodule Beepbopskeet.PlaylistsTest do
  use Beepbopskeet.DataCase

  alias Beepbopskeet.Playlists

  describe "submissions" do
    alias Beepbopskeet.Playlists.Submission

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", release_date: ~N[2010-04-17 14:00:00], url: "some url"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", release_date: ~N[2011-05-18 15:01:01], url: "some updated url"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, release_date: nil, url: nil}

    def submission_fixture(attrs \\ %{}) do
      {:ok, submission} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Playlists.create_submission()

      submission
    end

    test "list_submissions/0 returns all submissions" do
      submission = submission_fixture()
      assert Playlists.list_submissions() == [submission]
    end

    test "get_submission!/1 returns the submission with given id" do
      submission = submission_fixture()
      assert Playlists.get_submission!(submission.id) == submission
    end

    test "create_submission/1 with valid data creates a submission" do
      assert {:ok, %Submission{} = submission} = Playlists.create_submission(@valid_attrs)
      assert submission.email == "some email"
      assert submission.first_name == "some first_name"
      assert submission.last_name == "some last_name"
      assert submission.release_date == ~N[2010-04-17 14:00:00]
      assert submission.url == "some url"
    end

    test "create_submission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Playlists.create_submission(@invalid_attrs)
    end

    test "update_submission/2 with valid data updates the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{} = submission} = Playlists.update_submission(submission, @update_attrs)
      assert submission.email == "some updated email"
      assert submission.first_name == "some updated first_name"
      assert submission.last_name == "some updated last_name"
      assert submission.release_date == ~N[2011-05-18 15:01:01]
      assert submission.url == "some updated url"
    end

    test "update_submission/2 with invalid data returns error changeset" do
      submission = submission_fixture()
      assert {:error, %Ecto.Changeset{}} = Playlists.update_submission(submission, @invalid_attrs)
      assert submission == Playlists.get_submission!(submission.id)
    end

    test "delete_submission/1 deletes the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{}} = Playlists.delete_submission(submission)
      assert_raise Ecto.NoResultsError, fn -> Playlists.get_submission!(submission.id) end
    end

    test "change_submission/1 returns a submission changeset" do
      submission = submission_fixture()
      assert %Ecto.Changeset{} = Playlists.change_submission(submission)
    end
  end
end
