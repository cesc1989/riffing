require 'amazing_print'

# Vamos a probar Enumerable#partition
#
# La documentación dice que sirve para devolver un array de arrays, donde cada array contenga los elementos que cumplan con la condición del bloque.

personas = [
  { nombre: 'Francho', genero: 'masculino' },
  { nombre: 'Juana', genero: 'femenino' },
  { nombre: 'Pepita', genero: 'femenino' },
  { nombre: 'Felipe', genero: 'masculino' }
]

r = personas.partition { |persona| persona[:genero] == 'masculino' }

# ap r

# Asignando los resultados directamente a las variables

hombres, mujeres = personas.partition { |persona| persona[:genero] == 'masculino' }

ap hombres

ap mujeres