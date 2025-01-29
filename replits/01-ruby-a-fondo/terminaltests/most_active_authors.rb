#!/bin/ruby

#
# Complete the 'getUsernames' function below.
#
# The function is expected to return a STRING_ARRAY.
# The function accepts INTEGER threshold as parameter.
#
# URL for cut and paste
# https://jsonmock.hackerrank.com/api/article_users?page=<pageNumber>
#
require 'json'
require 'stringio'
require 'net/http'

def getUsernames(threshold)
  page = 1
  results = []
  
  loop do
    res = Net::HTTP.get_response(URI("https://jsonmock.hackerrank.com/api/article_users?page=#{page}"))
    res = JSON.parse(res.body)

    current_page = res['page']
    total_pages = res['total_pages']

    results.concat(extract_usernames_from(res['data'], threshold))
    
    break if current_page == total_pages
    
    page += 1
  end
  
  results.compact
end

def extract_usernames_from(data, threshold)
  data.map do |u|
    u['username'] if u['submission_count'] > threshold
  end
end
