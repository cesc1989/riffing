require "bundler/setup"
require "active_record"
require "logger"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :projects do |t|
    t.string :name, null: false
  end

  create_table :tasks do |t|
    t.string :name, null: false
    t.references :project
  end

  create_table :categories do |t|
    t.string :name, null: false
    t.references :project
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Project < ApplicationRecord
  # Desactivo el inverse y puedo ver en el log que hay una query adicional. Innecesaria.
  has_many :tasks, inverse_of: false

  # inverse_of está activo por defecto por Rails. No más queries.
  has_many :categories
end

class Task < ApplicationRecord
  belongs_to :project
end

class Category < ApplicationRecord
  belongs_to :project
end

p1 = Project.create(name: "Proyecto 1")
p1.tasks.create(name: "Tarea 1")
p1.categories.create(name: "Categoría 1")

t1 = p1.tasks.first
c1 = p1.categories.first

puts "Nombre del Proyecto"
p p1.name

puts "Nombre del proyecto desde la Tarea. Habrá dos queries"
# Task Load (0.0ms)  SELECT "tasks".* FROM "tasks" WHERE "tasks"."project_id" = ? ORDER BY "tasks"."id" ASC LIMIT ?  [["project_id", 1], ["LIMIT", 1]]
# Project Load (0.0ms)  SELECT "projects".* FROM "projects" WHERE "projects"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
p t1.project.name

puts "Nombre del proyecto desde la Categoría. Se reusa el objeto en memoria."
p c1.project.name
