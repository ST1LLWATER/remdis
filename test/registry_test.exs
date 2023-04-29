defmodule KV.RegistryTest do
  use ExUnit.Case, async: true
  alias KV.{Registry, Bucket}

  setup do
    registry = start_supervised!(Registry)
    %{registry: registry}
  end

  test "spawns bucket", %{registry: registry} do
    assert Registry.lookup(registry, "shopping") == :error

    Registry.create(registry, "shopping")
    assert {:ok, shopping} = Registry.lookup(registry, "shopping")

    Bucket.put(shopping, "milk", 2)
    assert Bucket.get(shopping, "milk") == 2
  end
end
