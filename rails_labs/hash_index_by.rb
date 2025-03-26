# Esto es una prueba de un cambio que hizo Alexis en un PR en Luna y me llamó la atención
# cómo logró lo mismo con un método diferente pero de Rails.

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  gem "amazing_print"
  gem "activesupport", "7.1.4"
end

require "active_support"
require "active_support/core_ext/enumerable" # Para soporte de deep_symbolize_keys
require "active_support/core_ext/hash" # Para soporte de with_indifferent_access

require "amazing_print"

ARY = [
  {
    field: "name",
    title: "Nombre completo",
    question: "Por favor ingresa tu nombre completo",
    default: nil,
    required: true
  },
  {
    field: "email",
    title: "Correo electrónico",
    question: "¿Cuál es tu dirección de correo electrónico?",
    default: "ejemplo@dominio.com",
    required: true
  },
  {
    field: "experience",
    title: "Años de experiencia",
    question: "¿Cuántos años de experiencia tienes en este campo?",
    default: "0",
    required: false
  }
]

def prueba_uno
  ARY.to_h do |auto_chart_question|
    # Aquí lo que se está haciendo es hacer un subarray donde:
    # - el 1er elemento es el valor del atributo :field
    # - el 2do elemento es un hash con los demás elementos que no son :field
    #   - con reject se evita elegir el atributo :field
    #
    r = [auto_chart_question[:field], auto_chart_question.reject { |k, _| k == :field }.with_indifferent_access]

    # ap r imprime algo como:
    # ["name", {title:, question:, default:, required:}]
  end.compact.with_indifferent_access
end

# Esta versión hace lo mismo que prueba_uno pero con menos lógica.
#
# Esto dicen los docs de index_by:
#     Convert an enumerable to a hash, using the block result as the key and the element as the value.
#
def prueba_dos
  ARY.index_by do |auto_chart_question|
    # Aquí index_by lo que hace es tomar el valor de `delete` como la llave.
    # Esto porque `delete` devuelve el valor del atributo.
    #
    # Por su parte, como se está borrando el atributo `field` del elemento
    # lo que termina haciendo el bloque en cada iteración es algo como:
    #
    # ["name", {title:, question:, default:, required:}]
    #
    key = auto_chart_question.delete(:field)
    # ap key # "name"
    # ap auto_chart_question # {title:, question:, default:, required:}

    key
  end.compact.deep_symbolize_keys
end

ap prueba_uno
ap prueba_dos
