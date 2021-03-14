defmodule WorksWeb.ProjectView do
  use WorksWeb, :view
  use JaSerializer.PhoenixView

  location '/projects/:id'

  attributes [:project_number, :project_name, :start_date, :end_date, :status]

end
