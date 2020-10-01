defmodule BeepbopskeetWeb.SubmissionControllerTest do
  use BeepbopskeetWeb.ConnCase

  alias Beepbopskeet.Playlists

  @create_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", release_date: ~N[2010-04-17 14:00:00], url: "some url"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", release_date: ~N[2011-05-18 15:01:01], url: "some updated url"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, release_date: nil, url: nil}

  def fixture(:submission) do
    {:ok, submission} = Playlists.create_submission(@create_attrs)
    submission
  end

  describe "index" do
    test "lists all submissions", %{conn: conn} do
      conn = get(conn, Routes.submission_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Submissions"
    end
  end

  describe "new submission" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.submission_path(conn, :new))
      assert html_response(conn, 200) =~ "New Submission"
    end
  end

  describe "create submission" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.submission_path(conn, :create), submission: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.submission_path(conn, :show, id)

      conn = get(conn, Routes.submission_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Submission"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.submission_path(conn, :create), submission: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Submission"
    end
  end

  describe "edit submission" do
    setup [:create_submission]

    test "renders form for editing chosen submission", %{conn: conn, submission: submission} do
      conn = get(conn, Routes.submission_path(conn, :edit, submission))
      assert html_response(conn, 200) =~ "Edit Submission"
    end
  end

  describe "update submission" do
    setup [:create_submission]

    test "redirects when data is valid", %{conn: conn, submission: submission} do
      conn = put(conn, Routes.submission_path(conn, :update, submission), submission: @update_attrs)
      assert redirected_to(conn) == Routes.submission_path(conn, :show, submission)

      conn = get(conn, Routes.submission_path(conn, :show, submission))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, submission: submission} do
      conn = put(conn, Routes.submission_path(conn, :update, submission), submission: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Submission"
    end
  end

  describe "delete submission" do
    setup [:create_submission]

    test "deletes chosen submission", %{conn: conn, submission: submission} do
      conn = delete(conn, Routes.submission_path(conn, :delete, submission))
      assert redirected_to(conn) == Routes.submission_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.submission_path(conn, :show, submission))
      end
    end
  end

  defp create_submission(_) do
    submission = fixture(:submission)
    {:ok, submission: submission}
  end
end
