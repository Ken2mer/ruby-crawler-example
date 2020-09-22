# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

rss = URI.open('https://trends.google.co.jp/trends/trendingsearches/daily/rss?geo=JP')

doc = Nokogiri::XML(rss)
doc.css('item').each.with_index(1) do |element, index|
  puts index
  puts element.css('title').text
  puts element.css('link').text
  puts
end
