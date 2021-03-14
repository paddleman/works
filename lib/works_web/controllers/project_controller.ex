defmodule WorksWeb.ProjectController do
  use WorksWeb, :controller

  alias Works.Projects
  alias Works.Projects.Project

  action_fallback WorksWeb.FallbackController

  def index(conn, _params) do
    projects = Projects.list_projects()
    render(conn, "index.json-api", data: projects)
  end

  def create(conn, %{"data" => data = %{"type" => "projects", "attributes" => project_params}}) do
    with {:ok, %Project{} = project} <- Projects.create_project(project_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.project_path(conn, :show, project))
      |> render("show.json-api", data: project)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Projects.get_project!(id)
    render(conn, "show.json-api", data: project)
  end

  def update(conn, %{"data" => data =  %{"id" => id, "type" => "projects", "attributes"=> project_params}}) do
    project = Projects.get_project!(id)

    with {:ok, %Project{} = project} <- Projects.update_project(project, project_params) do
      render(conn, "show.json-api", data: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Projects.get_project!(id)

    with {:ok, %Project{}} <- Projects.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end