defmodule BeepbopskeetWeb.AnnouncementController do
  use BeepbopskeetWeb, :controller

  alias Beepbopskeet.Admin
  alias Beepbopskeet.Admin.Announcement

  # def index(conn, _params) do
  #   announcements = Admin.list_announcements()
  #   render(conn, "index.html", announcements: announcements)
  # end

  # def new(conn, _params) do
  #   changeset = Admin.change_announcement(%Announcement{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"announcement" => announcement_params}) do
  #   case Admin.create_announcement(announcement_params) do
  #     {:ok, announcement} ->
  #       conn
  #       |> put_flash(:info, "Announcement created successfully.")
  #       |> redirect(to: Routes.announcement_path(conn, :show, announcement))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   announcement = Admin.get_announcement!(id)
  #   render(conn, "show.html", announcement: announcement)
  # end

  def edit(conn, %{"id" => id}) do
    announcement = Admin.get_announcement!(id)
    changeset = Admin.change_announcement(announcement)
    render(conn, "edit.html", announcement: announcement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "announcement" => announcement_params}) do
    announcement = Admin.get_announcement!(id)

    case Admin.update_announcement(announcement, announcement_params) do
      {:ok, announcement} ->
        conn
        |> put_flash(:info, "Announcement updated successfully.")
        |> redirect(to: Routes.admin_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", announcement: announcement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    announcement = Admin.get_announcement!(id)
    {:ok, _announcement} = Admin.delete_announcement(announcement)

    conn
    |> put_flash(:info, "Announcement deleted successfully.")
    |> redirect(to: Routes.admin_path(conn, :index))
  end

end
