defmodule Imagerepository.Account.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :caption, :string
    field :tag, :string
    field :url, :string
    belongs_to(:user, Imagerepository.Account.User)
    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:tag, :caption, :url])
    |> assoc_constraint(:user)
    |> validate_required([:tag, :caption, :url])
  end
end
