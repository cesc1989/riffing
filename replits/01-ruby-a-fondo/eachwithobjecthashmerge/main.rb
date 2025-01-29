sin_map = ['a', 'b', 'c'].each_with_object({}) do |letter, memo|
  memo.merge(letter => 'mundo')
end

pp sin_map

con_map = ['a', 'b', 'c'].each_with_object({}).map do |letter, memo|
  memo.merge(letter => 'mundo')
end

pp con_map