defmodule Imagerepository.AccountTest do
  use Imagerepository.DataCase

  alias Imagerepository.Account

  describe "users" do
    alias Imagerepository.Account.User

    @valid_attrs %{email: "some email", username: "some username"}
    @update_attrs %{email: "some updated email", username: "some updated username"}
    @invalid_attrs %{email: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "images" do
    alias Imagerepository.Account.Image
    alias Imagerepository.Account.User

    @valid_attrs %{
      caption: "some caption",
      tag: "some tag",
      url: "/some/image.jpg"
    }
    @update_attrs %{
      caption: "some updated caption",
      tag: "some updated tag",
      url: "/some/updated.jpg"
    }
    @invalid_attrs %{caption: nil, tag: nil}

    def image_fixture(%User{} = user, attrs \\ %{}) do
      attrs = Enum.into(attrs, @valid_attrs)

      {:ok, image} =
        %Image{}
        |> Image.changeset(attrs)
        |> Ecto.Changeset.put_assoc(:user, user)
        |> Repo.insert()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture(user_fixture())
      assert Map.delete(image.user, :users) == Map.delete(image.user, :users)
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Account.create_image(@valid_attrs)
      assert image.caption == "some caption"
      assert image.tag == "some tag"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture(user_fixture())
      assert {:ok, %Image{} = image} = Account.update_image(image, @update_attrs)
      assert image.caption == "some updated caption"
      assert image.tag == "some updated tag"
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture(user_fixture())
      assert {:ok, %Image{}} = Account.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Account.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture(user_fixture())
      assert %Ecto.Changeset{} = Account.change_image(image)
    end
  end
end
