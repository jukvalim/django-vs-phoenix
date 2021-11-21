defmodule EventsPhoenix.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EventsPhoenix.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_time: ~U[2021-11-20 17:21:00Z],
        name: "some name",
        start_time: ~U[2021-11-20 17:21:00Z]
      })
      |> EventsPhoenix.Events.create_event()

    event
  end
end
