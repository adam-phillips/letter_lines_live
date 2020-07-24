defmodule LetterLinesLive.Repo do
  use Ecto.Repo,
    otp_app: :letter_lines_live,
    adapter: Ecto.Adapters.Postgres
end
