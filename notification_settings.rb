# Communication Preferences
#
# Patients can receive notifications via email, sms, and/or push notifications if they've installed the mobile app.
# They might receive different notifications depending on the process they're involve and don't have a way to turn them off.
# Let's allow them to configurate the type of notification they want to receive depending on specific processes.
# For example, turn off sms for appointment reminders but leave email and push on.

class NotificationsController < ApplicationControlller
  def notification_params
    params.permit(:flow_name, enabled: [:name])
  end
end

class Patient
  has_many :notifications
end

class Notification
  belongs_to :patient

  # flow_name :string
  # enabled :array
end

# [
#   {
#     flow_name: 'appointment_reminders',
#     enabled: ['email', 'push']
#   }
# ]

class Appointment
  belongs_to :patient

  after_create :setup_notification

  def setup_notification
    patient.notifications.create(
      {
        flow_name: 'appointment_reminders',
        enabled: ['email', 'push', 'sms']
      }
    )
  end
end

class ExerciseProgram
  belongs_to :patient

  after_create :setup_notification

  def setup_notification
    patient.notifications.create(
      {
        flow_name: 'new_exercise_program',
        enabled: ['email', 'push', 'sms']
      }
    )
  end
end

class NotificationType
  # name :string
end

class AppointmentReminderWorker
  def trigger
    nots = patient.notifications.where(flow_name: 'appointment_reminders').where.not(enabled: [])

    nots.last.enabled.each do |e|
      #
    end
  end
end
