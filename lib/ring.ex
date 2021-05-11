defmodule Ring do
  @moduledoc """
  Documentation for `Ring`.
  """

  @doc """
  Start ring with specific number of nodes and required rounds
  """
  @spec play(nodes :: pos_integer, rounds :: pos_integer) :: any
  def play(nodes, rounds) do
    nodes
    |> create_ring()
    |> start_rounds()
    |> main_loop(rounds * nodes)
  end

  defp create_ring(nodes) do
    do_create_ring(self(), nodes - 1)
  end

  defp do_create_ring(pid, 1), do: spawn_node(pid)

  defp do_create_ring(pid, nodes) do
    pid
    |> spawn_node()
    |> do_create_ring(nodes - 1)
  end

  defp spawn_node(child_pid), do: spawn(__MODULE__, :loop, [child_pid])

  def loop(child_pid) do
    receive do
      {:msg, count} ->
        send_count(child_pid, count + 1, fn -> loop(child_pid) end)

      :shoutdown ->
        send_shoutdown(child_pid)
    end
  end

  defp start_rounds(child_pid) do
    IO.inspect("send from #{inspect(self())}, 1")
    send(child_pid, {:msg, 1})

    child_pid
  end

  defp main_loop(child_pid, total_count) do
    receive do
      {:msg, ^total_count} ->
        send_shoutdown(child_pid)

      {:msg, count} ->
        send_count(child_pid, count + 1, fn -> main_loop(child_pid, total_count) end)
    end
  end

  defp send_count(child_pid, count, loop_fn) do
    IO.inspect("send from #{inspect(self())}, #{count}")

    send(child_pid, {:msg, count})
    loop_fn.()
  end

  defp send_shoutdown(child_pid) do
    send(child_pid, :shoutdown)

    IO.inspect("bye from #{inspect(self())}")
  end
end
