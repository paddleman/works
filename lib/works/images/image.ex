defmodule Works.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :caption, :string
    field :date_taken, :date
    field :latitude, :float
    field :longitude, :float
    field :name, :string

    belongs_to :project, Works.Projects.Project

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:name, :caption, :latitude, :longitude, :date_taken])
    |> validate_required([:name, :caption, :latitude, :longitude, :date_taken])
  end
end
