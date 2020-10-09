defmodule BeepbopskeetWeb.Email do
  use Bamboo.Phoenix, view: BeepbopskeetWeb.EmailView

  def accepted_email(submission, playlist) do
    payload = Map.new([{:submission, submission}, {:playlist, playlist}])

    new_email
    |> from("playlists@beepbopskeet.com")
    |> to(submission.email)
    |> put_html_layout({BeepbopskeetWeb.LayoutView, "email.html"})
    |> subject("Your playlist submision")
    |> assign(:payload, payload)
    |> render("submission_accepted_email.html")
  end

  def submission_active_email(submission, playlist) do
    payload = Map.new([{:submission, submission}, {:playlist, playlist}])

    new_email
    |> from("playlists@beepbopskeet.com")
    |> to(submission.email)
    |> put_html_layout({BeepbopskeetWeb.LayoutView, "email.html"})
    |> subject("Your submission is active!")
    |> assign(:payload, payload)
    |> render("submission_active_email.html")
  end

end
