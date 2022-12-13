defmodule StordAssessment.Repo do
  use Ecto.Repo,
    otp_app: :stord_assessment,
    adapter: Ecto.Adapters.Postgres
end
