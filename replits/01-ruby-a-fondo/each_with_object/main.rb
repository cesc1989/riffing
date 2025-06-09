require "amazing_print"

sin_map = ["a", "b", "c"].each_with_object({}) do |letter, memo|
  # De esta forma, no se llena el hash en memo.
  # memo.merge(letter => "mundo")

  # Con esta forma sí llenamos el hash en memo.
  memo[letter] = "mundo"
end

pp sin_map

con_map = ["a", "b", "c"].each_with_object({}).map do |letter, memo|
  memo.merge(letter => "mundo")
end

pp con_map
