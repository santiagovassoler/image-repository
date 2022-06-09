defmodule ImagerepositoryWeb.Schema do
  use Absinthe.Schema
  import BatchLoader.Absinthe, only: [resolve_assoc: 1]
  import_types(Absinthe.Plug.Types)
  alias Imagerepository.Account

  def plugins do
    [BatchLoader.Absinthe.Plugin] ++ Absinthe.Plugin.defaults()
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

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
    field(:user, :user, resolve: resolve_assoc(:user))
  end

  input_object :image_filter do
    field :url, :string
    field :caption, :string
    field :tag, :string
  end

  query do
    @desc "Get a list of images"
    field :images, list_of(:image) do
      arg(:limit, :integer)
      arg(:order, type: :sort_order, default_value: :asc)
      arg(:filter, :image_filter)

      resolve(fn _, args, _ ->
        {:ok, Account.list_images(args)}
      end)
    end

    @desc "Get a single user by its id"
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

    field :upload_image, :image do
      arg(:caption, non_null(:string))
      arg(:tag, non_null(:string))
      arg(:file_data, non_null(:upload))
      arg(:user_id, non_null(:id))

      resolve(fn args, _ ->
        path_upload = args.file_data
        File.cp(path_upload.path, Path.absname("priv/static/uploads/#{path_upload.filename}"))
        args = Map.merge(args, %{url: path_upload.filename})
        Account.create_image(args)
      end)
    end
  end
end
