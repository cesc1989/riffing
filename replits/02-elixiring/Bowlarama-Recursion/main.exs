defmodule Recursivar do
  def pinfalls(scores) do
    calculate(scores, [])
  end

  defp calculate([[fst, sec | _], [n1, n2 | _] | rest], []) when fst == 10 do
    calculate([[n1, n2] | rest], [fst + sec + n1 + n2])
  end

  defp calculate([[fst, sec | _], [n1 | frame] | rest], []) when fst + sec == 10 do
    calculate([[n1 | frame] | rest], [fst + sec + n1])
  end

  defp calculate([[fst, sec | _] | rest], []) do
    calculate(rest, [fst + sec])
  end

  defp calculate([[fst, sec | _], [n1, n2 | _] | rest], [ff | tail]) when fst == 10 do
    next_score = ff + fst + sec + n1 + n2

    calculate([[n1, n2] | rest], [next_score, ff | tail])    
  end

  defp calculate([[fst, sec | _], [n1 | frame] | rest], [ff | tail]) when fst + sec == 10 do
    next_score = ff + fst + sec + n1

    calculate([[n1 | frame] | rest], [next_score, ff | tail])    
  end

  defp calculate([[fst, sec | _] | rest], [ff | tail]) do
    next_score = ff + fst + sec

    calculate(rest, [next_score, ff | tail])
  end

  defp calculate([], result) do
    Enum.reverse(result) |>
    IO.inspect
  end
end
Recursivar.pinfalls([[10,0], [7,3], [9,0], [10,0], [0,8], [8,2], [0,6], [10,0], [10,0], [0,10], [8,1]])

#	1. 20, -> 10 + (7,3)
#	2. 39, -> (20) + (7+3) + (9)
#	3. 48, -> (39) + (9+0)
#	4. 66, -> (48) + (10) + (0+8)
#	5. 74, -> (66) + (0+8)
#	6. 84, -> (74) + (8+2) + (0)
#	7. 90, -> (84) + (0+6)
#	8. 110, -> (90) + (10) + (10)
#	9. 130, -> (110) + (10) + (10)
#	10. 148, -> (130) + (0+10) + (8)