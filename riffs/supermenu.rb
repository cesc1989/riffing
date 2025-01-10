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
  create_table :teams do |t|
    t.string :name, null: false
  end

  create_table :restaurants do |t|
    t.string :name, null: false
    t.references :team
  end

  create_table :locations do |t|
    t.string :name, null: false
    t.references :restaurant
  end

  create_table :categories do |t|
    t.string :name, null: false
    t.references :restaurant
  end

  create_table :menus do |t|
    t.string :name, null: false
    t.references :location
  end

  create_table :dishes do |t|
    t.string :name, null: false
    t.references :category
  end

  create_table :menu_dishes do |t|
    t.references :menu
    t.references :dish
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Team < ApplicationRecord
  has_many :restaurants
end

class Restaurant < ApplicationRecord
  belongs_to :team, optional: true

  has_many :locations
  has_many :categories

  has_many :dishes, through: :categories
end

# Para restaurantes con varias sedes.
class Location < ApplicationRecord
  belongs_to :restaurant

  has_many :menus
  has_many :dishes, through: :menus
end

class Category < ApplicationRecord
  belongs_to :restaurant

  has_many :dishes
end

class Menu < ApplicationRecord
  belongs_to :location

  has_many :menu_dishes
  has_many :dishes, through: :menu_dishes
end

class Dish < ApplicationRecord
  belongs_to :category
end

class MenuDish < ApplicationRecord
  belongs_to :menu
  belongs_to :dish
end

gordales = Restaurant.create(name: 'Gordales')
gordales.locations.create([ { name: 'San José' }, { name: 'Paraíso' } ])

san_jose = gordales.locations.first

gordales.categories.create(
  [
    { name: 'Perrales', restaurant: gordales },
    { name: 'Hamburguesales', restaurant: gordales }
  ]
)

perrales = gordales.categories.first
menu = san_jose.menus.create(name: 'Menú San José')

5.times do |i|
  Dish.create(name: "Platosky #{i}", category: perrales)
end

menu.dish_ids = gordales.dishes.ids

binding.irb
