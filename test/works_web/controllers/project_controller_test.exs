defmodule WorksWeb.ProjectControllerTest do
  use WorksWeb.ConnCase

  alias Works.Projects
  alias Works.Projects.Project

  @create_attrs %{
    end_date: ~D[2010-04-17],
    project: "some project",
    project_name: "some project_name",
    project_number: "some project_number",
    start_date: ~D[2010-04-17],
    status: "some status"
  }
  @update_attrs %{
    end_date: ~D[2011-05-18],
    project: "some updated project",
    project_name: "some updated project_name",
    project_number: "some updated project_number",
    start_date: ~D[2011-05-18],
    status: "some updated status"
  }
  @invalid_attrs %{end_date: nil, project: nil, project_name: nil, project_number: nil, start_date: nil, status: nil}

  def fixture(:project) do
    {:ok, project} = Projects.create_project(@create_attrs)
    project
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all projects", %{conn: conn} do
      conn = get(conn, Routes.project_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create project" do
    test "renders project when data is valid", %{conn: conn} do
      conn = post(conn, Routes.project_path(conn, :create), project: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.project_path(conn, :show, id))

      assert %{
               "id" => id,
               "end_date" => "2010-04-17",
               "project" => "some project",
               "project_name" => "some project_name",
               "project_number" => "some project_number",
               "start_date" => "2010-04-17",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.project_path(conn, :create), project: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update project" do
    setup [:create_project]

    test "renders project when data is valid", %{conn: conn, project: %Project{id: id} = project} do
      conn = put(conn, Routes.project_path(conn, :update, project), project: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.project_path(conn, :show, id))

      assert %{
               "id" => id,
               "end_date" => "2011-05-18",
               "project" => "some updated project",
               "project_name" => "some updated project_name",
               "project_number" => "some updated project_number",
               "start_date" => "2011-05-18",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, project: project} do
      conn = put(conn, Routes.project_path(conn, :update, project), project: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete project" do
    setup [:create_project]

    test "deletes chosen project", %{conn: conn, project: project} do
      conn = delete(conn, Routes.project_path(conn, :delete, project))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.project_path(conn, :show, project))
      end
    end
  end

  defp create_project(_) do
    project = fixture(:project)
    %{project: project}
  end
end
