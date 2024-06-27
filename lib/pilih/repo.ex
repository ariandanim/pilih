defmodule Pilih.Repo do
  use Ecto.Repo,
    otp_app: :pilih,
    adapter: Ecto.Adapters.Postgres
end
