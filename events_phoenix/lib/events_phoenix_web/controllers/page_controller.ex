defmodule EventsPhoenixWeb.PageController do
  use EventsPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
