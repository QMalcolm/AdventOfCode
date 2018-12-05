defmodule AdventOfCode.SantasWarehouse do

  def box_ids_checksum() do
    AdventOfCode.Resource.local_stream("box_ids.txt")
    |> Enum.reduce([], fn x, acc -> [x | acc] end)
    |> twos_and_threes()
    |> IO.puts
  end

  defp twos_and_threes(list, twos \\ 0, threes \\ 0)
  defp twos_and_threes([], twos, threes), do: (twos * threes)
  defp twos_and_threes([id | tail], twos, threes) do
    as_list = String.graphemes(id)
    twos = if has_an_exact_dup?(as_list) do
      twos + 1
    else
      twos
    end
    threes = if has_an_exact_trip?(as_list) do
      threes + 1
    else
      threes
    end
    twos_and_threes(tail, twos, threes)
  end

  defp has_an_exact_dup?(list) when is_list(list) do
    !(Enum.uniq(list)
    |> Enum.find(fn x ->
      Enum.count(list, fn y -> y == x end) == 2
    end)
    |> is_nil)
  end

  defp has_an_exact_trip?(list) when is_list(list) do
    !(Enum.uniq(list)
    |> Enum.find(fn x ->
      Enum.count(list, fn y -> y == x end) == 3
    end)
    |> is_nil)
  end
end
