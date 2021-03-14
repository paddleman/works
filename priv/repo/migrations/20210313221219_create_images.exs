defmodule Works.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :name, :string
      add :caption, :string
      add :latitude, :float
      add :longitude, :float
      add :date_taken, :date

      add :project_id, references(:project)


      timestamps()
    end

  end
end
