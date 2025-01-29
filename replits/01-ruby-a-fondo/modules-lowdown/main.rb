module V12Engine
  def start; "...roar!"; end
end

module ElectricEngine
  def drive; "eco-driving!"; end
end

module SuperCar
  def fly; "flying!"; end
end

class Car
  include V12Engine
  prepend ElectricEngine
  extend SuperCar
  
  def drive
    "driving"
  end
  
  def start
    "..brrrrrrrmmm!"
  end
end

class Trabant < Car
end

my_car = Car.new
puts my_car.start
puts my_car.drive
puts Car.fly
my_car.extend(SuperCar)
puts my_car.fly

#puts my_car.singleton_class
#puts my_car.singleton_class.class
#puts my_car.singleton_class.superclass

module A; end
module B; end
module C; end
  
class MyClass
  include A
  prepend B
  extend C
end

#print MyClass.ancestors
#puts ""
#print MyClass.singleton_class.ancestors