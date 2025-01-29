require_relative 'ayer/b'

module Ayer
end

# Ayer::B::C.new.say

###### Prueba de Otra cosa

# Esto es una prueba de clases anidadas
#
# Aquí solo se anidan en un namespace. Son públicas para todos
# quienes lo invoquen.
class Exterior
  def prueba_exterior
    puts "Desde afuera"
  end

  class Interior
    def prueba_interior
      puts "desde adentro"
    end
  end

  class SuperInterior
    def muy_adentro
      puts "muuuy adentro"
    end
  end

  private_constant :SuperInterior
end

# p Exterior::Interior.ancestors

muy_adentro = Exterior::SuperInterior.new
p muy_adentro.muy_adentro
