defmodule StordAssessment.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :url, :string, null: false
      add :hash, :string
      add :visits, :integer

      timestamps()
    end

    create unique_index(:urls, [:url], name: "url_unique")
  end
end
