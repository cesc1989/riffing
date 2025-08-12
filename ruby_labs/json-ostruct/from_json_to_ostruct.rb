require "json"
require "amazing_print"
require "ostruct"

json_fixture = File.read(File.join(__dir__, "fixture.json"))

# Para replicar la estructura de subclasses del SDK de Athena en Ruby me tocó usar
# mucho OpenStruct. En el archivo ./fixture.json se puede ver el anidamiento de las llaves.
# Eso mismo pasa con Athena.
#
# Usar JSON.parse(source, object_class: OpenStruct) puedo convertir un JSON con esa estructura
# a toda la jerarquia con OpenStruct. Siendo JSON una estructura de datos más fácil de manipular
# que OpenStruct.
athena_struct = JSON.parse(json_fixture, object_class: OpenStruct)

ap athena_struct
ap athena_struct.dig(:result_set)

ap athena_struct.dig(:result_set, :rows)
