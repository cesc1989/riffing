require 'bundler/inline'

gemfile true do
 source 'http://rubygems.org'
 gem 'retriable'
end

require 'retriable'

Retriable.retriable(intervals: [5, 15, 30]) do
  puts "tryinnng"

  1 / 0
end

# Primer intento sin usar retriable
# tryinnng

# Segundo intento 5 segundos después
# tryinnng

# Tercer intento 15 segundos después
# tryinnng

# Cuarto intento 30 segundos después
# tryinnng # imprime y luego explota
# main.rb:12:in `/': divided by 0 (ZeroDivisionError)