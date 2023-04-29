defmodule BucketTest do
  use ExUnit.Case, async: false
  alias KV.Bucket

  setup do
    bucket = start_supervised!(Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert Bucket.get(bucket, "milk") == nil

    Bucket.put(bucket, "milk", 3)
    assert Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key", %{bucket: bucket} do
    Bucket.put(bucket, "milk", 3)
    Bucket.put(bucket, "eggs", 5)
    Bucket.put(bucket, "spinach", 2)

    Bucket.delete(bucket, "milk")

    assert Bucket.get(bucket, "milk") == nil
  end
end
