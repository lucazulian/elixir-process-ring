defmodule CommandValidationBench do
  @moduledoc """

  mix run bench/benchmark.exs
  """

  Benchee.run(
    %{
      small_ring: fn -> Ring.play(10, 2) end,
      medium_ring: fn -> Ring.play(100, 2) end,
      big_ring: fn -> Ring.play(1_000, 2) end
    },
    warmup: 0,
    time: 10,
    parallel: 1,
    memory_time: 2
  )
end
