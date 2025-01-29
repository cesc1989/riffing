_CSV_HEADER = [
    # plan details
    "patient_id",
    "care_plan_id",
    "total_completed_visits",
    "latest_visit_date",
    "appointment_id",
    "prescribed_by_therapist_id",
    "sanitized_plan_text",
    "continuation",
    # summary fields
    "anticipated_discharge_date",
    "visits_remaining",
    "total_expected_visits",
    # entry details
    "total_entries",
    "entry1_frequency_lower",
    "entry1_frequency_upper",
    "entry1_duration_lower",
    "entry1_duration_upper",
    "entry1_total_lower",
    "entry1_total_upper",
    "entry2_frequency_lower",
    "entry2_frequency_upper",
    "entry2_duration_lower",
    "entry2_duration_upper",
    "entry2_total_lower",
    "entry2_total_upper",
    "entry3_frequency_lower",
    "entry3_frequency_upper",
    "entry3_duration_lower",
    "entry3_duration_upper",
    "entry3_total_lower",
    "entry3_total_upper",
    "entry4_frequency_lower",
    "entry4_frequency_upper",
    "entry4_duration_lower",
    "entry4_duration_upper",
    "entry4_total_lower",
    "entry4_total_upper",
    "entry5_frequency_lower",
    "entry5_frequency_upper",
    "entry5_duration_lower",
    "entry5_duration_upper",
    "entry5_total_lower",
    "entry5_total_upper",
]

visit_plan_data_obj = {
    'patient_id': '913caa71-6a17-4ccd-bce6-64c204430200',
    'care_plan_id': '79a34cce-01ad-4b28-bf77-ee6485e2c144',
    'total_completed_visits': 1,
    'latest_visit_date': '2021-12-29',
    'appointment_id': 'dc5a85f9-92a7-47c0-9e71-2d10e8d086c2',
    'prescribed_by_therapist_id': 'e285bbcd-50b5-43c1-a038-3ed27fda7ff2',
    'sanitized_plan_text': 'Tst',
    'continuation': 'false',
    'anticipated_discharge_date': '2022-01-26',
    'visits_remaining': '11',
    'total_expected_visits': '12',
    'total_entries': '1',
    'entry1_frequency_lower': '3',
    'entry1_frequency_upper': '3',
    'entry1_duration_lower': '4',
    'entry1_duration_upper': '4',
    'entry1_total_lower': '12',
    'entry1_total_upper': '12',
    'entry2_frequency_lower': '',
    'entry2_frequency_upper': '',
    'entry2_duration_lower': '',
    'entry2_duration_upper': '',
    'entry2_total_lower': '',
    'entry2_total_upper': '',
    'entry3_frequency_lower': '',
    'entry3_frequency_upper': '',
    'entry3_duration_lower': '',
    'entry3_duration_upper': '',
    'entry3_total_lower': '',
    'entry3_total_upper': '',
    'entry4_frequency_lower': '',
    'entry4_frequency_upper': '',
    'entry4_duration_lower': '',
    'entry4_duration_upper': '',
    'entry4_total_lower': '',
    'entry4_total_upper': '',
    'entry5_frequency_lower': '',
    'entry5_frequency_upper': '',
    'entry5_duration_lower': '',
    'entry5_duration_upper': '',
    'entry5_total_lower': '',
    'entry5_total_upper': ''
}

# row = "hola"

for i in range(len(_CSV_HEADER)):
  # Imprime cada valor del CSV
  # print(_CSV_HEADER[i])
  # Imprime cada value del hash según la key
  #print(visit_plan_data_obj[_CSV_HEADER[i]])
  norow = visit_plan_data_obj[_CSV_HEADER[i]]

# print(row)

result = [visit_plan_data_obj[_CSV_HEADER[i]] for i in range(len(_CSV_HEADER))]

print("|".join(map(str, result)))

# found here https://stackoverflow.com/a/34477119/1407371
# values = ",".join(map(str, value_list))