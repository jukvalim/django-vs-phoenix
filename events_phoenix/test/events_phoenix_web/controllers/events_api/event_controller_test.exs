defmodule EventsPhoenixWeb.EventsApi.EventControllerTest do
  use EventsPhoenixWeb.ConnCase

  import EventsPhoenix.EventsFixtures

  alias EventsPhoenix.Events.Event

  @create_attrs %{
    description: "some description",
    end_time: ~U[2021-11-20 18:39:00Z],
    name: "some name",
    start_time: ~U[2021-11-20 18:39:00Z]
  }
  @update_attrs %{
    description: "some updated description",
    end_time: ~U[2021-11-21 18:39:00Z],
    name: "some updated name",
    start_time: ~U[2021-11-21 18:39:00Z]
  }
  @invalid_attrs %{description: nil, end_time: nil, name: nil, start_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get(conn, Routes.events_api_event_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event" do
    test "renders event when data is valid", %{conn: conn} do
      conn = post(conn, Routes.events_api_event_path(conn, :create), event: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.events_api_event_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "end_time" => "2021-11-20T18:39:00Z",
               "name" => "some name",
               "start_time" => "2021-11-20T18:39:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.events_api_event_path(conn, :create), event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: %Event{id: id} = event} do
      conn = put(conn, Routes.events_api_event_path(conn, :update, event), event: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.events_api_event_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "end_time" => "2021-11-21T18:39:00Z",
               "name" => "some updated name",
               "start_time" => "2021-11-21T18:39:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      conn = put(conn, Routes.events_api_event_path(conn, :update, event), event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event" do
    setup [:create_event]

    test "deletes chosen event", %{conn: conn, event: event} do
      conn = delete(conn, Routes.events_api_event_path(conn, :delete, event))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.events_api_event_path(conn, :show, event))
      end
    end
  end

  defp create_event(_) do
    event = event_fixture()
    %{event: event}
  end
end
