require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  gem "rails", "7.0.4"
  gem "sqlite3", "1.7.0"
end

require "active_record"
require "minitest/autorun"
require "logger"

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :patients, force: true do |t|
  end

  create_table :episodes, force: true do |t|
    t.integer :patient_id
  end

  create_table :appointments, force: true do |t|
    t.integer :episode_id
  end

  create_table :protocol_submissions, force: true do |t|
    t.integer :appointment_id
  end

  create_table :protocol_escalations, force: true do |t|
    t.integer :protocol_submission_id
  end
end

class Patient < ActiveRecord::Base
  has_many :episodes
end

class Episode < ActiveRecord::Base
  belongs_to :patient

  has_many :appointments
end

class Appointment < ActiveRecord::Base
  belongs_to :episode

  has_one :protocol_submission
end

class ProtocolSubmission < ActiveRecord::Base
  belongs_to :appointment

  has_one :protocol_escalation

  has_one :episode, through: :appointment
end

class ProtocolEscalation < ActiveRecord::Base
  belongs_to :protocol_submission

  has_one :episode, through: :protocol_submission
  has_one :patient, through: :episode
end

class BugTest < Minitest::Test
  def test_association_stuff
    patient = Patient.create!

    episode = Episode.create!
    patient.episodes << episode

    appointment = Appointment.create!
    episode.appointments << appointment

    submission = ProtocolSubmission.create!
    appointment.protocol_submission = submission

    escalation = ProtocolEscalation.create!
    submission.protocol_escalation = escalation

    # assert_equal 1, post.comments.count
    # assert_equal 1, Comment.count
    assert_equal patient.id, Episode.first.patient.id
    assert_equal patient.id, episode.patient.id
  end
end
