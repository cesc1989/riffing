# Prueba del modelo Organization para que sea este el dueño de los recursos creados por los usuarios de un sistema.
#
#  Ejecuta así:
#
#    bundle exec ruby organization.rb

require "bundler/setup"
require "active_record"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :organizations do |t|
    t.string :name, null: false
    t.string :slug, null: false
  end

  # The Invitation can be claimed by either a new or existing User,
  # even if the email address doesn’t match where the invitation was delivered too.
  #
  # The Invitation goes away once claimed.
  create_table :invitations do |t|
    t.string :email
    t.string :uuid
    t.integer :from_membership_id

    t.references :organization
  end

  # A User belongs to a Organization through a Membership.
  create_table :users do |t|
    t.string :first_name, null: false
    t.string :last_name, null: false
    t.string :email, default: "", null: false

    t.integer :current_organization_id
  end

  # The Membership can have one or more Roles associated with it.
  #
  # The Membership model itself can be extended by developers to include additional
  # types of permissions that can be configured on a per-Membership basis,
  # e.g. access to certain features or specific resources.
  #
  # When adding a new Membership, an Invitation is also created and sent via email.
  create_table :memberships do |t|
    # SQLite aún(?) no tiene soporte para JSONB. Toca usar JSON.
    # t.jsonb :role_ids, default: []
    t.json :role_ids, default: []

    t.references :organization
    t.references :user
    t.references :invitation
  end

  create_table :roles do |t|
    t.string :name, null: false
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :invitations
end

class Invitation < ApplicationRecord
  belongs_to :organization
  belongs_to :from_membership, class_name: "Membership"

  has_one :membership, dependent: :nullify
end

class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  # Aquí está el uso de current_organization_id
  belongs_to :current_organization, class_name: "Organization", optional: true
end

class Membership < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :organization
  belongs_to :invitation, optional: true, dependent: :destroy
end

class Role < ApplicationRecord; end

org1 = Organization.create(name: "Coshito", slug: "coshito")

user1 = User.create(first_name: "Fran", last_name: "Cisco", email: "correo@mail.com")

mem1 = Membership.create(organization: org1, user: user1)

binding.irb
