convertable_list = [
  "photo",
  "malpractice_liability_insurance_coverage",
  "resume",
  "physical_therapy_diploma"
]

skip_list = [
  "photo.jpeg",
  "photo.png",
  "malpractice_liability_insurance_coverage.pdf",
  "malpractice_liability_insurance_coverage.jpeg",
  "resume.pdf",
  "resume.jpeg",
  "physical_therapy_diploma.pdf",
  "physical_therapy_diploma.jpeg"
]

if "photo" not in convertable_list:
  print("No se hará nada con este")

if "resume.pdf" in skip_list:
  print("Sí está en la lista")

if ".txt" in "hola.txt":
  print("Sí es un te equis te")

print("photo.jpg".split(".")[0])