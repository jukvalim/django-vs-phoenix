defmodule EventsPhoenix.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :start_time, :utc_datetime, null: false
      add :end_time, :utc_datetime, null: false
      add :description, :text, null: false, default: ""

      timestamps()
    end
  end
end
