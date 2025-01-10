# Quiero encontrar una solución al detalle de deep_munge de Strong Parameters por el cual
# esto `value: [nil, nil, false]` termina siendo esto `value: [false]`.
#
# No importa que pase la transformación pero poder reconvertir el array a la estructura inicial.

require "amazing_print"

default = [nil, nil, false]
one = [false]
two = [10, false]
three = ["running", 2, true]

class ActivityValues
  VALID_ABILITIES = (0..10).freeze

  def initialize(value_ary)
    @value_ary = value_ary
  end

  def parse
    return @value_ary if @value_ary.size == 3

    [name, ability, other_name]
  end

  def name
    return nil if @value_ary.size == 1

    nil
  end

  def ability
    return nil if @value_ary.size == 1

    @value_ary.first if VALID_ABILITIES.include?(@value_ary.first)
  end

  def other_name
    return false if @value_ary.size == 1

    @value_ary.last
  end
end


ap ActivityValues.new(one).parse
ap ActivityValues.new(two).parse
ap ActivityValues.new(three).parse
