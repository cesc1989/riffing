require "amazing_print"

class HubspotSyncCustomObjectsIdsToTherapistService
  HS_RESPONSE = {
    "id": "101298279979",
    "properties":
    {
      "createdate": "2025-02-22T00:41:28.056Z",
      "email": "francisco.quintero+7612@ideaware.co",
      "firstname": "Prueba X3 AF",
      "hs_object_id": "101298279979",
      "lastmodifieddate": "2025-02-24T22:17:54.488Z",
      "lastname": "Prueba X3 AF"
    },
    "createdAt": "2025-02-22T00:41:28.056Z",
    "updatedAt": "2025-02-24T22:17:54.488Z",
    "archived": false,
    "associations":
    {
      "p7712148_therapist_addresses":
      {
        "results":
          [
            {
              "id": "24395548205",
              "type": "contact_to_therapist_addresses"
            },
            {
              "id": "24432646309",
              "type": "contact_to_therapist_addresses"
            },
            {
              "id": "24395548205",
              "type": "current_address"
            },
            {
              "id": "24432646309",
              "type": "relocation_address"
            }
          ]
      },
      "p7712148_credentialings":
      {
        "results":
        [
          {
            "id": "24387600522",
            "type": "contact_to_credentialings"
          },
          {
            "id": "24435403289",
            "type": "contact_to_credentialings"
          },
          {
            "id": "24387600522",
            "type": "active_attested"
          },
          {
            "id": "24435403289",
            "type": "processing_for_move"
          }
        ]
      }
    }
  }

  def sync_ids
    association_keys = HS_RESPONSE[:associations].keys

    %w[credentialing therapist_address].each do |co_name|
      co_hash = association_keys.select { |k| k.to_s.include?(co_name) }
      ap co_hash

      next unless co_hash.any?

      co_objects = HS_RESPONSE.dig(:associations, co_hash.first, :results)
      # ap co_objects

      co_objects.each do |co_object|
        case co_object[:type]
        when "processing_for_move"
          ap co_object[:id]
          # @therapist.send("credentialing_relocation_id=", co_object[:id])
        when "active_attested"
          ap co_object[:id]
          # @therapist.send("credentialing_active_attested_id=", co_object[:id])
        when "active"
          ap co_object[:id]
          # @therapist.send("credentialing_hubspot_id=", co_object[:id])
        when "inactive"
          ap co_object[:id]
          # @therapist.send("credentialing_inactive_hubspot_id=", co_object[:id])
        when "current_address"
          ap co_object[:id]
          # @therapist.send("credentialing_current_address_id=", co_object[:id])
        end
      end
    end
  end
end

HubspotSyncCustomObjectsIdsToTherapistService.new.sync_ids
