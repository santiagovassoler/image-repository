defmodule ImagerepositoryWeb.PageController do
  use ImagerepositoryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
