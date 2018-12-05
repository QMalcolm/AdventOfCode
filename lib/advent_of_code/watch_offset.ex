defmodule AdventOfCode.WatchOffset do
  def compute() do
    #stream = File.stream!()
    Path.expand("./resources/watch_offsets.txt")
    |> File.stream!
    |> Enum.reduce(0, fn x, acc ->
      {int, _} = Integer.parse(x)
       acc + int
     end)
    |> IO.puts
  end
end
