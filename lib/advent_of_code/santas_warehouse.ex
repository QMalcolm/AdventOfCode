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

  def find_id_intersect() do
    AdventOfCode.Resource.local_stream("box_ids.txt")
    |> Enum.reduce([], fn x, acc -> [String.graphemes(x) | acc] end)
    |> find_id_intersect
    |> IO.puts
  end

  defp find_id_intersect([]), do: nil
  defp find_id_intersect([head | tail]) do
    case find_diff_of_one(tail, head) do
      nil ->
        find_id_intersect(tail)
      result ->
        result
    end
  end

  defp find_diff_of_one([], _ref), do: nil
  defp find_diff_of_one([head | tail], ref) do
    case diff_ids(ref, head) do
      {1, result} ->
        result
      _ ->
        find_diff_of_one(tail, ref)
    end
  end

  defp diff_ids(list1, list2, diff \\ 0, result \\ "")
  defp diff_ids([], [], diff, result), do: {diff, result}
  defp diff_ids([head1 | tail1], [head2 | tail2], diff, result) do
    if head1 == head2 do
      diff_ids(tail1, tail2, diff, result <> head1)
    else
      diff_ids(tail1, tail2, diff + 1, result)
    end
  end
end
