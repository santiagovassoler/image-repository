defmodule Imagerepository.Account.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :caption, :string
    field :tag, :string
    belongs_to(:user, ImageRepository.Account.User)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:tag, :caption, :user_id])
    |> validate_required([:tag, :caption, :user_id])
  end
end
