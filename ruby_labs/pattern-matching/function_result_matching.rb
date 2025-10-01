# Esto es una prueba de algo que vi en un PR en Luna.
#
# Me llamó la atención la forma usar el pattern matching con la salida de la función.
#
# Me confundió el uso de hash-rocket después de la función y por eso vine a probarlo.
#
def evaluate_cycles(events:, reference_time:)
  {
    expected_cycles: [1, 2, 3],
    current_cycle: 2,
    meta: { at: reference_time, events_count: events.size }
  }
end

events = ["a", "b", "c"]

# Aquí ocurre el pattern matching.
#
# evaluate_cycles devuelve tres llaves en el hash pero con el patrón solo extraemos dos.
# Al hacer la extracción la asigna a las variables `expected_cycles` y `current_cycle`.
#
evaluate_cycles(events: events, reference_time: Time.now) => { expected_cycles:, current_cycle: }

puts "expected_cycles => #{expected_cycles.inspect}"
puts "current_cycle   => #{current_cycle}"
