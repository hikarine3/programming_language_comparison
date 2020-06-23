require 'open-uri'
require 'nokogiri'

target_url = "https://www.yahoo.com/"
doc = Nokogiri.HTML(open(target_url))
doc.search('title').each do |elm|
    puts elm.content
end