#  Ejecuta así:
#
#    bundle exec ruby enum_prefix.rb
#

require "bundler/setup"
require "active_record"
require "amazing_print"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :medicare_dollar_threshold_statuses, force: true do |t|
    t.datetime :effective_from
    t.datetime :effective_until
  end
end

class MedicareDollarThresholdStatus < ActiveRecord::Base; end

[2023, 2024, 2025, 2027].each do |year|
  beg_date = DateTime.new(year, 1, 1).beginning_of_year
  end_date = DateTime.new(year, 12, 31).end_of_year

  MedicareDollarThresholdStatus.create(effective_from: beg_date, effective_until: end_date)
end

def find_statuses_in(years)
  conditions = years.map do |year|
    "(effective_from = :start_#{year} AND effective_until = :end_#{year})"
  end.join(" OR ")

  params =
    years.index_with do |year|
      beginning_of_year = DateTime.new(year, 1, 1).beginning_of_year
      end_of_year = DateTime.new(year, 12, 31).end_of_year

      { "start_#{year}": beginning_of_year, "end_#{year}": end_of_year }
    end
    .values
    .reduce(&:merge)

  MedicareDollarThresholdStatus.where(conditions, params)
end

appt_years = [2023,2024,2025,2026].to_set

statuses_in_years = find_statuses_in(appt_years)
mdts_years = statuses_in_years.map { |status| status.effective_from.year }.to_set

ap "Appt years: #{appt_years}"
ap "MTDS years: #{mdts_years}"

missing_years = appt_years - mdts_years

ap "Extra years: #{mdts_years - appt_years}"
ap "Missing years: #{missing_years}"

if missing_years.length.positive?
  missing_years.each do |year|
    beginning_of_year = DateTime.new(year, 1, 1).beginning_of_year
    end_of_year = DateTime.new(year, 12, 31).end_of_year

    MedicareDollarThresholdStatus.create(effective_from: beginning_of_year, effective_until: end_of_year)
  end
end

ap MedicareDollarThresholdStatus.pluck(:id, :effective_from, :effective_until)
# binding.irb
