# Esto lo vi en Luna y me llamó la atención el signo negativo en el bloque de sort_by
#
# Con el signo negativo se le indica al evaluador de sort_by que el ordenamiento será
# en orden descendente (de mayor a menor). El signo menos adelante implica una multiplicación
# por -1.

require "ostruct"
require "amazing_print"

schedules = [
  OpenStruct.new(day_past_due: 5),
  OpenStruct.new(day_past_due: 10),
  OpenStruct.new(day_past_due: 3)
]

sorted_schedules = schedules.sort_by { |schedule| -schedule.day_past_due }

ap sorted_schedules
# [
#     [0] OpenStruct {
#         :day_past_due => 10
#     },
#     [1] OpenStruct {
#         :day_past_due => 5
#     },
#     [2] OpenStruct {
#         :day_past_due => 3
#     }
# ]
