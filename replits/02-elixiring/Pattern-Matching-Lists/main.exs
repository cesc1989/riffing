[head | tail] = [1, 2, 3]
IO.puts(head)
IO.inspect(tail)

[head_2] = [10]
IO.puts(head_2)

[a, b | _rest] = [1, 2]
IO.puts(a)
IO.puts(b)

[first, second] = [11,22]
IO.puts(first)
IO.puts(second)

l = [first | 33]
IO.inspect(l)