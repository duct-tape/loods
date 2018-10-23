defmodule Loods.Parts.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :description, :string
    field :location, :string
    field :name, :string
    field :part_number, :string
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :part_number, :location, :quantity, :description])
    |> validate_required([:name, :part_number, :location, :quantity, :description])
  end
end
