require "amazing_print"

notification_settings = {
  new_chat_messages: 0,
  new_bookings: 1,
  scheduling_changes: 2,
  therapist_waitlist_match_updates: 3,
  therapist_weekly_availability_reminder: 4,
  # patient notifications
  appointment_reminders: 5,
  exercise_program_created: 6,
  exercise_program_updated: 7,
  exercise_reminders: 8
}

patient_notification_settings = %w[
  appointment_reminders
  exercise_program_created
  exercise_program_updated
  exercise_reminders
]
account_id = "xxxxxxxxx"
comm_methods = %w[email sms push]
exercise_reminders_comm_methods = %w[sms push]
now = Time.now

settings = notification_settings.each_key
  .select { |kind| patient_notification_settings.include?(kind.to_s) }
  .map do |kind|
    {
      account_id: account_id,
      kind: kind,
      communication_methods: kind.to_s == "exercise_reminders" ? exercise_reminders_comm_methods : comm_methods,
      enabled: true,
      created_at: now,
      updated_at: now
    }
  end

ap settings

