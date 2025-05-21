require "amazing_print"

r1 = Ractor.new(name: "r1") do
  loop do
    input = Ractor.receive

    result = input + 2

    puts "Executed - result will be: #{result}"

    Ractor.yield(result)
  end
end


ap r1.name

ap r1.inspect

r1.send(1)

r1.send(2)

r1.take

r1.take

ap r1.inspect

r1.take

