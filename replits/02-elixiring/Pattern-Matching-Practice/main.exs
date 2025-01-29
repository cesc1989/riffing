# Maps

%{amount: value} = %{name: "Your Customer, Inc", amount: 142}
IO.puts(value)

%{"name" => name} = %{"name" => "Your Customer, Inc", "amount" => 142}
IO.puts(name)

%{"name" => _, "amount" => amount} = %{"name" => "Your Customer, Inc", "amount" => 142}
IO.puts(amount)

# Tuples

{:ok, answer} = {:ok, 1500}
IO.puts(answer)

{_year, month, _day} = {2020, 2, 14}
IO.puts(month)