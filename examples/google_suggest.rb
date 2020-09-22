# frozen_string_literal: true

require 'open-uri'
require 'uri'
require 'rexml/document'

print 'キーワードを入力してください: '
keyword = gets

if keyword == "\n"
  print '入力がありませんでした'
  return
end

puts

base_url = 'http://www.google.com/complete/search?hl=ja&output=toolbar'
data = URI.encode_www_form({ q: keyword })
url = "#{base_url}&#{data}"

doc = REXML::Document.new(URI.open(url).read.encode('UTF-8'))
doc.elements.each('toplevel/CompleteSuggestion/suggestion') do |element|
  puts element.attributes['data']
end
