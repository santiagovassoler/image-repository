defmodule Imagerepository.Repo.Migrations.AddImageUrlToImage do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :url, :string
    end
  end
end
