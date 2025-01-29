defmodule Roman do
 @naturals [1000, 900, 500, 400, 100, 50, 40, 10, 9, 5, 4, 1]
 @romans %{
		1=>"I",
    4=>"IV",
    5=>"V",
    9=>"IX",
    10=>"X",
    40=>"XL",
    50=>"L",
    90=>"XC",
    100=>"C",
    400=>"CD",
    500=>"D",
    900=>"CM",
    1000=>"M"
	}

  def numeral(0), do: ""

  def numeral(number) when number > 0 do
    separator = Enum.find(@naturals, fn(x) -> x <= number end)

    {_nat, roman_str} = Enum.find(@romans, fn({k,_v}) -> separator == k end)

    roman_str <> numeral(number - separator)
  end
end

IO.puts(Roman.numeral(93))