defmodule Topu do
  def update_list do
    scores = ["10","7","3","9","0","10","0","8","8","2","0","6","10","10","10","8"]

    process(scores)
  end

  defp process(scores) do
    process(scores, [])
  end

  defp process([first | rest], new_list) when first == "10" do
    process(rest, [first, "0" | new_list])
  end

  defp process([first | rest], new_list) do
    process(rest, [first | new_list])
  end

  defp process([], new_list) do
    Enum.reverse(new_list)
  end
end

# IO.inspect Enum.chunk_every(Topu.update_list, 2, 2, :discard)
#IO.inspect(Topu.update_list)

lista = [[10, 0], [2,5]]
[[f | _] | _s] = lista
IO.inspect(f)