# Este es un archivo de prueba para saber cómo ejecutar futuros riffs y, pues, probar.
#
# Se ejecuta así:
#
#    bundle exec ruby prueba.rb
#
# Active Record
#
# Esta configuración que usa ActiveRecord solo es necesaria si quiero probar los modelos.
# De resto, puedo hacer el modelado solo con clases e imaginarme el resto de cosas según lo que entiendo de cómo funciona Rails.

require "bundler/setup"
require "active_record"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :posts do |t|
    t.string :title, null: false
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Post < ApplicationRecord
end

post = Post.create!(title: 'Prueba')

binding.irb
