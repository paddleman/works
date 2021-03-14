defmodule Works.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :project_number, :string
    field :project_name, :string
    field :start_date, :date
    field :end_date, :date
    field :status, :string

    has_many :images, Works.Images.Image

    timestamps()
  end

  def changeset(project, attrs) do
    project
    |> cast(attrs, [:project_number, :project_name, :start_date, :end_date, :status])
    |> validate_required([:project_number, :project_name,:start_date, :status])
  end
end
