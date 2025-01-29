class BaseClass
  attr_reader :una
  attr_reader :from
  
  def initialize(max: 1000, from: '90')
    @una = 'una'
    @dos = 'dos'
    @max = max
  end

  def results
    [1,2,3,4]
  end
end

# El orden donde se usa super no afecta
class Hija < BaseClass
  def initialize
    # super
    
    @tres = 'tres'
    
    super
  end
end

h = Hija.new
pp h.una

# El argumento debe estar en la clase hija
# y en la clase padre
class Hijo < BaseClass
  # attr_reader :from
  
  def initialize(from: '90')
    # super

    @from = if from == '90'
              'noventa'
            else
              'siempre'
            end

    super
  end
end

hijo = Hijo.new(from: '100')
pp hijo.from