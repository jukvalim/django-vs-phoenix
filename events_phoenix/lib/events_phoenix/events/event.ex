defmodule EventsPhoenix.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :start_time, :end_time, :description])
    |> validate_required([:name, :start_time, :end_time, :description])
  end
end
