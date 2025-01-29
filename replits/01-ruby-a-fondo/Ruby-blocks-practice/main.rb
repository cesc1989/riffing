class A
  attr_accessor :tales
  def initialize
    @tales = nil
  end
end

def especial_one(param)
  a = A.new
  puts 'I am'
  yield(a) if block_given?
  puts 'mou'

  puts a.tales
  puts param
end

especial_one('hola') do |a|
  a.tales = 'fayado'
  puts 'the special one'
end