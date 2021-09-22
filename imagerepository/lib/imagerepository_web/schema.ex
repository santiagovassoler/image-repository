defmodule ImagerepositoryWeb.Schema do
  use Absinthe.Schema
  alias Imagerepository.Account

  @desc "An User"
  object :user do
    field(:id, :id)
    field(:username, :string)
    field(:email, :string)
  end

  @desc "Image for an user"
  object :image do
    field(:id, :id)
    field(:caption, :string)
    field(:tag, :string)
    field(:url, :string)
  end

  query do
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(fn args, _ ->
        {:ok, Account.get_user!(args.id)}
      end)
    end
  end

  mutation do
    field :create_user, :user do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))

      resolve(fn args, _ ->
        Account.create_user(args)
      end)
    end

    field :add_image, :image do
      arg(:caption, non_null(:string))
      arg(:tag, non_null(:string))
      arg(:url, non_null(:string))
      arg(:user_id, non_null(:id))

      resolve(fn args, _ ->
        Account.create_image(args)
      end)
    end
  end
end
