defmodule KV.BucketTest do
  use ExUnit.Case, async: false

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    KV.Bucket.put(bucket, "eggs", 5)
    KV.Bucket.put(bucket, "spinach", 2)

    KV.Bucket.delete(bucket, "milk")

    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
