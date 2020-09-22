# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

url = 'http://info.finance.yahoo.co.jp/fx/detail/?code=USDJPY=FX'

doc = Nokogiri::HTML(URI.open(url))
bid = doc.css('#USDJPY_detail_bid').text
ask = doc.css('#USDJPY_detail_ask').text

puts "Bid(売値)：#{bid}"
puts "Ask(買値)：#{ask}"
