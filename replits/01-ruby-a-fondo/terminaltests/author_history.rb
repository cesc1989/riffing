require 'json'
require 'stringio'
require 'net/http'

def getAuthorHistory(author)
  history = []
  
  au_req = Net::HTTP.get_response(URI("https://jsonmock.hackerrank.com/api/article_users?username=#{author}"))
  au_res = JSON.parse(au_req.body)
  
  about = au_res["data"].first["about"]
  history << about unless about.empty?
  
  total_pages = 1
  page = 1
  
  loop do
    articles_req = Net::HTTP.get_response(URI("https://jsonmock.hackerrank.com/api/articles?author=#{author}&page=#{page}"))
    articles_res = JSON.parse(articles_req.body)
    
    articles_res["data"].each do |art|
      title = art["title"] || art["story_title"]
      history << title if title
    end
    
    break if articles_res["total_pages"] == 1
    
    total_pages += 1
    page += 1
  end
  
  history
end
