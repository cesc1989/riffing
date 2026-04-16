# frozen_string_literal: true

# Quiero probar que a una string frozen no le puedo hacer gsub!
#
# En cambio, a una string no frozen pero interpolada sí le puedo hacer gsub!

puts "String Freezeada"
cadena1 = "estoy frezeada"

begin
  puts "Prueba 1"
  puts cadena1.gsub!("estoy", "me")
rescue StandardError => e
  puts "Errorrrrr: #{e}"
end

puts "\nPrueba 2. Interpolación"
unvalor = "Qhubo"
cadena2 = "Orale carnal"

puts "\nCadena a gsubear: #{cadena2}"
puts "#{cadena2} - #{unvalor}".gsub!("Orale", "Saquese")
