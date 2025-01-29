# Seen https://medium.com/rubycademy/metaprogramming-ruby-hook-methods-25b279042be5

module Verification
  def self.included(klass)
    puts "I was included"
    puts klass
  end
end

class Uploader
  include Verification

  attr_reader :client
  def initialize
    @client = "Iam the client"
  end

  def upload
    puts "Uploaded file"
    true
  end
end

u = Uploader.new.upload