defmodule AdventOfCode.Resource do
  def local_file(filename) do
    local_path(filename)
    |> File.open()
  end

  def local_stream(filename) do
    local_path(filename)
    |> File.stream!()
  end

  def local_path(filename) do
    Path.expand("./resources") <> "/#{filename}"
  end
end
