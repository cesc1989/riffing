class A
  attr_accessor :tales

  def initialize
    @tales = nil
  end
end

# En este ejemplo el bloque se ejecuta si usa la función de esa form
#
#    especial_one {}
#
#    especial_one do
#    end
#
def especial_one(param)
  a = A.new

  puts "I am"

  yield(a) if block_given?

  puts "mou"

  puts ""
  puts "Soy el valor de a: #{a.tales}"
  puts "Soy el parametro de la función: #{param}"
end

especial_one("juan lainer") { puts "Sin usar el parametro" }

puts ""

especial_one("desde el parametro") do |a|
  a.tales = "fayado"

  puts "the special one"
end

begin
  especial_one { puts "Sin parametro de bloque" }
rescue ArgumentError => e
  puts ""
  puts "No se puede ejecutar la función si espera el parametro"
end
