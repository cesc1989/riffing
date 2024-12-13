# Menús de restaurantes para cargar desde celulares.
#
#  Ejecuta así:
#
#    bundle exec ruby enum_prefix.rb
#

require "bundler/setup"
require "active_record"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :invoicing_targets do |t|
    t.integer :status, null: false, default: 0
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class InvoicingTarget < ApplicationRecord
  enum status: {
    # No invoicing attempts have been made; target changes are allowed
    draft: 0,
    # No invoicing attempts have been made; target changes are NOT allowed
    frozen: 1,
    # We are about to attempt a charge or a charge is being attempted in Stripe (retrying)
    processing: 5,
    # Payment was successful
    succeeded: 10,
    # Manually aborted by a human operator or automatically aborted by the system due to changing circumstances
    cancelled: 20,
    # We were unable to collect from the patient
    failed: 666
  }#, _prefix: :invoice
end

it = InvoicingTarget.create
it2 = InvoicingTarget.create(status: 10)

binding.irb

# InvoicingTarget.succeeded.select(:id)
