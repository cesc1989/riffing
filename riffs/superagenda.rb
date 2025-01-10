# Agenda de consultorios clínicos.
#
#  Ejecuta así:
#
#    bundle exec ruby superagenda.rb
#
# Agenda web enfocada en citas y datos básicos de los pacientes. Buscar pacientes existenes para agendar controles.

require "bundler/setup"
require "active_record"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :patients do |t|
    t.string :first_name, null: false
    t.string :dni, null: false
  end

  create_table :guardians do |t|
    t.string :first_name, null: false
    t.string :phone_number, null: false
    t.references :patient
  end

  create_table :appointments do |t|
    t.datetime :scheduled_date, null: false
    t.integer :kind, null: false
    t.references :patient
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Patient < ApplicationRecord
  has_many :appointments
  has_one :guardian
end

class Guardian < ApplicationRecord
  belongs_to :patient
end

class Appointment < ApplicationRecord
  enum kind: { cita: 0, control: 1 }

  belongs_to :patient
end

susanito = Patient.create(first_name: 'Susanito', dni: '232323')
susanito.create_guardian(first_name: 'Papá', patient: susanito, phone_number: '39981278931')

primera_cita = Appointment.create(
  scheduled_date: '2024-04-20 12:20:00',
  kind: 0,
  patient: susanito
)

binding.irb
