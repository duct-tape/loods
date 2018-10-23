defmodule Loods.PartsTest do
  use Loods.DataCase

  alias Loods.Parts

  describe "items" do
    alias Loods.Parts.Item

    @valid_attrs %{description: "some description", location: "some location", name: "some name", part_number: "some part_number", quantity: 42}
    @update_attrs %{description: "some updated description", location: "some updated location", name: "some updated name", part_number: "some updated part_number", quantity: 43}
    @invalid_attrs %{description: nil, location: nil, name: nil, part_number: nil, quantity: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Parts.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Parts.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Parts.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Parts.create_item(@valid_attrs)
      assert item.description == "some description"
      assert item.location == "some location"
      assert item.name == "some name"
      assert item.part_number == "some part_number"
      assert item.quantity == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parts.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, item} = Parts.update_item(item, @update_attrs)
      assert %Item{} = item
      assert item.description == "some updated description"
      assert item.location == "some updated location"
      assert item.name == "some updated name"
      assert item.part_number == "some updated part_number"
      assert item.quantity == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Parts.update_item(item, @invalid_attrs)
      assert item == Parts.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Parts.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Parts.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Parts.change_item(item)
    end
  end
end
