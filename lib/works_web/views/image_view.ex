defmodule WorksWeb.ImageView do
  use WorksWeb, :view
  use JaSerializer.PhoenixView

  location 'images/:id'

  attributes [:name, :caption, :latitude, :longitude, :date_taken]

end
