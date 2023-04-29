defmodule KV.Registry do
  use GenServer
  alias KV.Bucket

  @doc """
  Starts the registry
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the bucket for the given `name`.
  
  Returns `{:ok, bucket(pid)}` if the bucket exists, otherwise `:error`.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a bucket for the given `name` in the registry.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.get(names, name), names}
  end

  @impl true
  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, bucket} = Bucket.start_link([])
      {:noreply, Map.put(names, name, bucket)}
    end
  end
end
