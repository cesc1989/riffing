require "enumerator"
require "amazing_print"

ary = Array.new(105, 5)
chunked = ary.each_slice(100).to_a

p chunked

