require "amazing_print"

class Categorized
  UNSEEN_CATEGORIES = {
    'Insurance Coverage Issue' => { 'percentage' => 0, 'amount' => 0 },
    'No Therapist Available' => { 'percentage' => 0, 'amount' => 0 },
    'Not Able to Connect' => { 'percentage' => 0, 'amount' => 0 },
    'Not Able to Contact' => { 'percentage' => 0, 'amount' => 0 },
    'Not Appropriate for Outpatient' => { 'percentage' => 0, 'amount' => 0 },
    'Not Interested in Care' => { 'percentage' => 0, 'amount' => 0 },
    'Other' => { 'percentage' => 0, 'amount' => 0 },
    'Out of Area' => { 'percentage' => 0, 'amount' => 0 },
    'Pending' => { 'percentage' => 0, 'amount' => 0 },
    'Treated by Another Clinic' => { 'percentage' => 0, 'amount' => 0 },
    'Unsupported Condition' => { 'percentage' => 0, 'amount' => 0 }
  }.freeze

  attr_reader :response

  def initialize
    @response = { data: UNSEEN_CATEGORIES.dup, total_response: 0 }
  end

  def doit
    @response[:data]['Other']['amount'] += 1
  end
end

prueba = Categorized.new
prueba.doit

ap prueba.response
