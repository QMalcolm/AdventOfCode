defmodule AdventOfCode.SuitFabric do

  def overlapping_inches() do
    instructions = AdventOfCode.Resource.local_stream("suit_fabric.txt")
    |> Enum.reduce([], fn x, acc -> [parse_instruction(x) | acc] end)
    matrix = Matrex.fill(1000, 0)
    matrix = place_all(instructions, matrix)
    over_used_inches(matrix) |> IO.puts
  end

  defp place_all([], matrix), do: matrix
  defp place_all([head | tail], matrix) do
    matrix = mark_overlap(head, matrix)
    place_all(tail, matrix)
  end

  defp mark_overlap(%{id: _id, x: x, y: y, width: width, height: height}, matrix) do
    x2 = x + width
    y2 = y + height
    mo_row_iteration(y..y2 |> Enum.to_list, x..x2 |> Enum.to_list, matrix)
  end

  defp mo_row_iteration([], _columns, matrix), do: matrix
  defp mo_row_iteration([head | tail], columns, matrix) do
    matrix = mo_row_column_iteration(head, columns, matrix)
    mo_row_iteration(tail, columns, matrix)
  end

  defp mo_row_column_iteration(_row, [], matrix), do: matrix
  defp mo_row_column_iteration(row, [head | tail], matrix) do
    new_matrix = Matrex.update(matrix, row + 1, head + 1, fn x -> x + 1 end)
    mo_row_column_iteration(row, tail, new_matrix)
  end

  defp parse_instruction(line) do
    split = String.split(line)
    id = Enum.at(split, 0)
    xy = Enum.at(split, 2) |> String.split(",")
    {x, _rem} = Enum.at(xy, 0) |> Integer.parse
    {y, _rem} = Enum.at(xy, 1) |> Integer.parse
    dimensions = Enum.at(split, 3) |> String.split("x")
    {width, _rem} = Enum.at(dimensions, 0) |> Integer.parse
    {height, _rem} = Enum.at(dimensions, 1) |> Integer.parse
    %{id: id, x: x, y: y, width: width, height: height}
  end

  defp over_used_inches(matrix) do
    Enum.reduce(1..1000, 0, fn row_index, acc ->
      row = Matrex.row_to_list(matrix, row_index)
      over_used_inches(row, acc)
    end)
  end

  defp over_used_inches([], sum), do: sum
  defp over_used_inches([head | tail], sum) do
    if head > 1 do
      over_used_inches(tail, sum + 1)
    else
      over_used_inches(tail, sum)
    end
  end

end
