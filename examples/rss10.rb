# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

url = 'https://b.hatena.ne.jp/hotentry/it.rss'
xml = URI.open(url).read

doc = Nokogiri::XML(xml)

namespaces = {
  # デフォルト名前空間
  'rss' => 'http://purl.org/rss/1.0/',
  'rdf' => 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
  'content' => 'http://purl.org/rss/1.0/modules/content/',
  'dc' => 'http://purl.org/dc/elements/1.1/',
  'feedburner' => 'http://rssnamespace.org/feedburner/ext/1.0'
}

# channel
channel = doc.xpath('//rss:channel', namespaces)

# Xpathでtitleを検索
# puts channel.xpath('rss:title', namespaces)
puts channel.xpath('feedburner:info', namespaces)
lis = channel.xpath('//rdf:li', namespaces)
lis.each do |li|
  # puts li.attribute('resource')
end

# CSSセレクタでtitleを検索
# puts doc.css('channel title')
items = doc.xpath('//rss:item', namespaces)
items.each do |item|
  puts item.xpath('rss:title', namespaces).inner_text
  # puts item.xpath('content:encoded', namespaces)
  puts item.xpath('dc:date', namespaces).inner_text
  puts
end
