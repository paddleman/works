defmodule Works.ImagesTest do
  use Works.DataCase

  alias Works.Images

  describe "images" do
    alias Works.Images.Image

    @valid_attrs %{caption: "some caption", date_taken: ~D[2010-04-17], latitude: 120.5, longitude: 120.5, name: "some name"}
    @update_attrs %{caption: "some updated caption", date_taken: ~D[2011-05-18], latitude: 456.7, longitude: 456.7, name: "some updated name"}
    @invalid_attrs %{caption: nil, date_taken: nil, latitude: nil, longitude: nil, name: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Images.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Images.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Images.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Images.create_image(@valid_attrs)
      assert image.caption == "some caption"
      assert image.date_taken == ~D[2010-04-17]
      assert image.latitude == 120.5
      assert image.longitude == 120.5
      assert image.name == "some name"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Images.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, %Image{} = image} = Images.update_image(image, @update_attrs)
      assert image.caption == "some updated caption"
      assert image.date_taken == ~D[2011-05-18]
      assert image.latitude == 456.7
      assert image.longitude == 456.7
      assert image.name == "some updated name"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Images.update_image(image, @invalid_attrs)
      assert image == Images.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Images.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Images.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Images.change_image(image)
    end
  end
end
