class Prueba
  attr_reader :name
  
  def initialize(name)
    @name = name
    @cosa = "hola"
  end

  def probina
    DentroPrueba.new.visible
  end

  private
  
  class DentroPrueba
    def visible
      puts name
    end
  end
end

prueba = Prueba.new("Prueba")
p prueba.probina