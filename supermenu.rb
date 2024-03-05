# Menús de restaurantes para cargar desde celulares.
#
#  Ejecuta así:
#
#    bundle exec ruby supermenu.rb
#
# Se acceden mediante URL o código QR. 100% responsive. Cargan muy rápido los detalles del restaurante y los elementos del menú.

require "bundler/setup"
require "active_record"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :restaurants do |t|
    t.string :name, null: false
  end

  create_table :locations do |t|
    t.string :name, null: false
    t.references :restaurant
  end

  create_table :categories do |t|
    t.string :name, null: false
    t.references :location
    t.references :restaurant
  end

  create_table :menus do |t|
    t.string :name, null: false
    t.references :location
  end

  create_table :dishes do |t|
    t.string :name, null: false
    t.references :menu
    t.references :category
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Restaurant < ApplicationRecord
  belongs_to :team, optional: true

  has_many :locations
  # has_many :categories, through: :locations

  has_many :categories
end

# Para restaurantes con varias sedes.
class Location < ApplicationRecord
  belongs_to :restaurant

  has_many :menus
  has_many :categories
end

class Menu < ApplicationRecord
  belongs_to :location

  has_many :dishes
end

class Dish < ApplicationRecord
  belongs_to :menu
  belongs_to :category
end

class Category < ApplicationRecord
  # ¿Debería pertenecer a location o a restaurant?
  #
  # Solo belongs_to :location
  #   -  No todos las sedes tendrían el mismo menú
  #   -  Tendría que duplicar categorías similares en sedes diferentes
  # belongs_to :location

  # Solo belongs_to :restaurant
  #   - location_id no nulo significa que el menú está disponible ahí
  #   - No habría que duplicar categorías para sedes distintas
  belongs_to :location, optional: true
  belongs_to :restaurant

  has_many :dishes
end

gordales = Restaurant.create(name: 'Gordales')
locations = gordales.locations.create(
  [
    { name: 'San José' },
    { name: 'Paraíso' }
  ]
)
san_jose = locations.first
paraiso = locations.last

gordales.categories.create(
  [
    { name: 'Perrales', restaurant: gordales, location: san_jose },
    { name: 'Hamburguesales', restaurant: gordales }
  ]
)

perrales = san_jose.categories.first

menu = san_jose.menus.create(name: 'Mega menu')

5.times do |i|
  Dish.create(name: "Platosky #{i}", menu: menu, category: perrales)
end

binding.irb
