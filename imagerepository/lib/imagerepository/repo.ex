defmodule Imagerepository.Repo do
  use Ecto.Repo,
    otp_app: :imagerepository,
    adapter: Ecto.Adapters.Postgres
end
