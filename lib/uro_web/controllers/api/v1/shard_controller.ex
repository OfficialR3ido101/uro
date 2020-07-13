defmodule UroWeb.API.V1.ShardController do
  use UroWeb, :controller
  alias Uro.VSekai

  def validate_ip(conn, shard) do
    shard[:id] == conn.remote_ip
  end

  def json_error(conn, status, errors) do
    conn
    |> put_status(status)
    |> json(errors: errors)
  end

  def json_error(conn, status) do
    conn
    |> put_status(status)
    |> json(%{errors: ""})
  end

  def index(conn, _params) do
    shards = VSekai.list_shards()
    conn
    |> put_status(200)
    |> json(%{data: %{shards: shards}})
  end

  def create(conn, %{"shard" => shard_params}) do
    shard_params = Map.put(shard_params, "address", to_string(:inet_parse.ntoa(conn.remote_ip)))

    case VSekai.create_shard(shard_params) do
      {:ok, shard} ->
        conn
        |> put_status(200)
        |> json(%{data: %{id: shard.id}})
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> json_error(400, changeset.errors)
    end
  end

  def update(conn, %{"id" => id, "shard" => shard_params}) do
    shard = VSekai.get_shard!(id)
    if shard[:address] == to_string(:inet_parse.ntoa(conn.remote_ip)) do
      case VSekai.update_shard(shard, shard_params) do
        {:ok, shard} ->
          conn
          |> put_status(200)
          |> json(%{data: %{id: shard.id}})
        {:error, %Ecto.Changeset{}}
          conn
          |> json_error(400)
      end
    else
      conn
      |> json_error(400)
    end
  end

  def delete(conn, %{"id" => id}) do
    shard = VSekai.get_shard!(id)
    if shard[:address] == to_string(:inet_parse.ntoa(conn.remote_ip)) do
      case VSekai.delete_shard(shard) do
        {:ok, shard} ->
          conn
          |> put_status(200)
          |> json(%{data: %{id: shard.id}})
        {:error, %Ecto.Changeset{}}
          conn
          |> json_error(400)
      end
    else
      conn
      |> json_error(400)
    end
  end
end
