# frozen_string_literal: true

require 'twitter'

config = {
  consumer_key: ENV['TWITTER_API_KEY'],
  consumer_secret: ENV['TWITTER_API_SECRET'],
  access_token: ENV['TWITTER_ACCESS_TOKEN'],
  access_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
}

# 日本
place_id = 23_424_856
client = Twitter::REST::Client.new(config)
client.trends(place_id).each do |trend|
  puts trend.name
  puts trend.url
  puts
end
