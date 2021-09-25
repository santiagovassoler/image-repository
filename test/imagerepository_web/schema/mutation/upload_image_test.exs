defmodule ImagerepositoryWeb.Schema.Mutation.UploadImageTest do
  use ExUnit.Case
  use ImagerepositoryWeb.ConnCase, async: true

  @query """
    mutation {
      uploadImage(
        caption: "image caption",
        tag: "some really nice tags",
        userId: 1
        file_data: "file_data_attribute_arbitraty_name"
        ) {
          caption
          tag
        }
      }
  """

  test "test uploadImage uploads a file", %{conn: conn} do
    upload = %Plug.Upload{
      content_type: "multipart/form-data",
      filename: "phoenix.png",
      path: "../../../priv/static/images/phoenix.png"
    }

    resp =
      conn
      |> post("/graphiql", %{"query" => @query, "file_data_attribute_arbitraty_name" => upload})

    assert %{
             "data" => %{
               "uploadImage" => %{
                 "caption" => "image caption",
                 "tag" => "some really nice tags"
               }
             }
           } == json_response(resp, 200)
  end
end
