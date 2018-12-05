defmodule AdventOfCode.WatchFrequencyOffset do
  def compute_sum() do
    #stream = File.stream!()
    AdventOfCode.Resource.local_stream("watch_offsets.txt")
    |> Enum.reduce(0, fn x, acc ->
      {int, _} = Integer.parse(x)
       acc + int
     end)
    |> IO.puts
  end

  def cycle_until_duplicate_frequency() do
    {:ok, val} = sum_cycle_until_duplicate([], %{0 => nil}, 0)
    IO.puts val
  end

  defp sum_cycle_until_duplicate([], keys, frequency) do
    list = AdventOfCode.Resource.local_stream("watch_offsets.txt")
    |> Enum.reduce([], fn x, acc ->
      {int, _} = Integer.parse(x)
      [int | acc]
    end)
    |> Enum.reverse
    sum_cycle_until_duplicate(list, keys, frequency)
  end

  defp sum_cycle_until_duplicate([head | tail], keys, frequency) do
    frequency = frequency + head
    if Map.has_key?(keys, frequency) do
      {:ok, frequency}
    else
      sum_cycle_until_duplicate(tail, Map.put(keys, frequency, nil), frequency)
    end
  end
end
