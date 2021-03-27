require 'open-uri'
require 'nokogiri'

target_url = "https://www.yahoo.com/"
doc = Nokogiri.HTML(open(target_url))
doc.search('title').each do |elm|
  raise "yahoo is not included in title" unless elm.content.match(/yahoo/i)
  puts("OK")
  break
end
