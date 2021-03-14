defmodule Works.ProjectsTest do
  use Works.DataCase

  alias Works.Projects

  describe "projects" do
    alias Works.Projects.Project

    @valid_attrs %{end_date: ~D[2010-04-17], project: "some project", project_name: "some project_name", project_number: "some project_number", start_date: ~D[2010-04-17], status: "some status"}
    @update_attrs %{end_date: ~D[2011-05-18], project: "some updated project", project_name: "some updated project_name", project_number: "some updated project_number", start_date: ~D[2011-05-18], status: "some updated status"}
    @invalid_attrs %{end_date: nil, project: nil, project_name: nil, project_number: nil, start_date: nil, status: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
      assert project.end_date == ~D[2010-04-17]
      assert project.project == "some project"
      assert project.project_name == "some project_name"
      assert project.project_number == "some project_number"
      assert project.start_date == ~D[2010-04-17]
      assert project.status == "some status"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Projects.update_project(project, @update_attrs)
      assert project.end_date == ~D[2011-05-18]
      assert project.project == "some updated project"
      assert project.project_name == "some updated project_name"
      assert project.project_number == "some updated project_number"
      assert project.start_date == ~D[2011-05-18]
      assert project.status == "some updated status"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end
