defmodule StordAssessment.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :url, :string
      add :hash, :string
      add :visits, :integer

      timestamps()
    end
  end
end
