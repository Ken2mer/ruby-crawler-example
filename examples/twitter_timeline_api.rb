# frozen_string_literal: true

require 'twitter'

config = {
  consumer_key: ENV['TWITTER_API_KEY'],
  consumer_secret: ENV['TWITTER_API_SECRET'],
  access_token: ENV['TWITTER_ACCESS_TOKEN'],
  access_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
}

client = Twitter::REST::Client.new(config)
client.user_timeline('Ken2mer').each do |tweet|
  # Tweet時間
  puts tweet.created_at

  # Tweet本文
  puts tweet.text

  puts
end
