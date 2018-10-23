defmodule Loods.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :part_number, :string
      add :location, :string
      add :quantity, :integer
      add :description, :string

      timestamps()
    end

  end
end
