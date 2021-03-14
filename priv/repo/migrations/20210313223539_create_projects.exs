defmodule Works.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :project_number, :string
      add :project_name, :string
      add :start_date, :date
      add :end_date, :date
      add :status, :string



      timestamps()
    end

  end
end
