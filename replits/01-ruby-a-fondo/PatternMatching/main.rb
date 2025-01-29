# data = [1,2]
# data = [1,2,3,4,5,6,7,8,9,10]
# data = {a: 2, b: 1}
data = :ok

case data
in [1]
  puts "Soy un array"
in [1,2]
  puts "array con dos elementos"
in {a: Integer}
  puts "soy un hash"
in :ok
  puts "soy un simbolo"
in [Integer, *]
  puts "soy un array de enteros"
else
  puts "no machea"
end

# Buscar patrón

ary = [1,2,:ok, :err]

case ary
in [*, Symbol, *]
  puts "macheo"
else
  puts "sin macheo"
end

# Variable Binding

case [1, 2]
in Integer => uno, Integer => dos
  puts "matched: #{uno} y #{dos}"
else
  puts "not matched"
end