# frozen_string_literal: true

require 'geocoder'

Geocoder.configure(language: 'ja', units: 'km')

addresses = Geocoder.search('550-0014', params: { countorycodes: 'ja' })
addresses.each do |result|
  # pp result
  puts "経度：#{result.latitude}"
  puts "緯度：#{result.longitude}"
end
