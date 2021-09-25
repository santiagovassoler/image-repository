defmodule ImagerepositoryWeb.Schema.Mutation.CreateUserTest do
  use ExUnit.Case
  use ImagerepositoryWeb.ConnCase, async: true

  @query """
  mutation ($email: string!, $username: string!) {
    createUser(email: $email, username: $username) {
      email
      username
    }
  }
  """

  test "createUser mutation creates a user" do
    input = %{
      "email" => "email@email.com",
      "username" => "someusername"
    }

    conn = build_conn()

    conn =
      post conn, "/graphiql",
        query: @query,
        variables: input

    assert %{
             "data" => %{
               "createUser" => %{
                 "email" => "email@email.com",
                 "username" => "someusername"
               }
             }
           } == json_response(conn, 200)
  end
end
