require "amazing_print"
# require "active_support"

class SyncHubspot
  HS_RESPONSE = {
    "vid": "12345",
    "properties": {
      "personal_reference_id": { "value": "100" },
      "personal_reference_name": { "value": "Jaime" },
      "personal_reference_email": { "value": "jaimito@gmail.com" },
      "personal_reference_phone": { "value": "315 250" },
      "personal_reference_title": { "value": "Sr" },

      "personal_reference_id_2": { "value": "200" },
      "personal_reference_name_2": { "value": "Paola" },
      "personal_reference_email_2": { "value": "paolita@aol.com" },
      "personal_reference_phone_2": { "value": "650 768" },
      "personal_reference_title_2": { "value": "Dr" },

      "personal_reference_id_3": { "value": "300" },
      "personal_reference_name_3": { "value": "Tony" },
      "personal_reference_email_3": { "value": "tonito@yahoo.es" },
      "personal_reference_phone_3": { "value": "190 293" },
      "personal_reference_title_3": { "value": "Mr" },

      "firstname": { "value": "Juancho" }
    }
  }

  def initialize
    @properties = HS_RESPONSE.fetch(:properties)
  end

  def update
    process_personal_references

    @properties.each do |property, value_hsh|
      next if property.to_s.start_with?("personal_reference_")

      ap "Segui en caso normal"
    end
  end

  private

  def process_personal_references
    references_data = {}

    @properties.each do |property, value_hsh|
      next unless property.to_s.start_with?("personal_reference_")

      ref_num = if property == :personal_reference_id
                  "1"
                elsif (match = property.to_s.match(/personal_reference_id_(\d+)/))
                  match[1]
                else
                  # Para otros campos:
                  # - personal_reference_name
                  # - personal_reference_name_2
                  # - personal_reference_name_3
                  # - etc
                  property.to_s.match(/personal_reference_([^_]+)_?(\d+)?/)[2] || "1"
                end

      field_name = property.to_s.gsub(/personal_reference_|_?\d+/, "")
      references_data[ref_num] ||= {}
      references_data[ref_num][field_name] = value_hsh[:value]
    end

    ap references_data

    references_data.each do |ref_num, props|
      # reference = PersonalReference.find_by(id: props["id"])

      # next unless reference

      attrs = {
        full_name: props["name"],
        email: props["email"],
        phone: props["phone"],
        title: props["title"]
      }.compact

      ap attrs
    end
  end
end

SyncHubspot.new.update
