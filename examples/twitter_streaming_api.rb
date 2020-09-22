# frozen_string_literal: true

require 'twitter'

config = {
  consumer_key: ENV['TWITTER_API_KEY'],
  consumer_secret: ENV['TWITTER_API_SECRET'],
  access_token: ENV['TWITTER_ACCESS_TOKEN'],
  access_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
}

client = Twitter::Streaming::Client.new(config)
client.sample do |tweet|
  # 日本語のつぶやきだけ表示
  if tweet.is_a?(Twitter::Tweet) && tweet.lang == 'ja'
    puts tweet.text
    puts
    puts
  end
end
