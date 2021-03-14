defmodule WorksWeb.ImageController do
  use WorksWeb, :controller

  alias Works.Images
  alias Works.Images.Image

  action_fallback WorksWeb.FallbackController

  def index(conn, _params) do
    images = Images.list_images()
    render(conn, "index.json-api", data: images)
  end

  def create(conn, %{"data" => data = %{"type" => "images", "attributes" => image_params}}) do
    with {:ok, %Image{} = image} <- Images.create_image(image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.image_path(conn, :show, image))
      |> render("show.json-api", data: image)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Images.get_image!(id)
    render(conn, "show.json-api", data: image)
  end

  def update(conn, %{"data" => data =  %{"id" => id, "type" => "images", "attributes"=> image_params}}) do
    image = Images.get_image!(id)

    with {:ok, %Image{} = image} <- Images.update_image(image, image_params) do
      render(conn, "show.json-api", data: image)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Images.get_image!(id)

    with {:ok, %Image{}} <- Images.delete_image(image) do
      send_resp(conn, :no_content, "")
    end
  end
end