# frozen_string_literal: true

require 'open-uri'
require 'rexml/document'
require 'nokogiri'

APPLICATION_ID = ENV['YAHOO_API_KEY']
BASE_URL = 'http://jlp.yahooapis.jp/KeyphraseService/V1/extract'

$word_list = {}

def request(text)
  app_id = APPLICATION_ID
  data = URI.encode_www_form({ sentence: text.to_s })
  params = "?appid=#{app_id}&output=xml&#{data}"
  url = "#{BASE_URL}#{params}"
  response = URI.open(url)

  # FIXME: レスポンスに不正な文字('&'など)があるとRuntimeErrorになる
  doc = REXML::Document.new(response).elements['ResultSet/']
  doc.elements.each('Result') do |element|
    text = element.elements['Keyphrase'][0]
    # score = element.elements['Score'][0]
    $word_list[text.to_s] = $word_list[text.to_s].to_i + 1
  end
end

def get_urls(page_url)
  urls = []
  uri = URI.parse(page_url)
  doc = Nokogiri::HTML(URI.open(page_url))
  anchors = doc.xpath("//*[@id='contents']//ul[@class='newsFeedTab_list']//a")
  anchors.each do |anchor|
    url = 'http://news.yahoo.co.jp' + anchor[:href]
    url = uri.merge(url) if uri !~ /^http/
    urls << url
  end
  urls
end

def get_headline_text(page_url)
  doc = Nokogiri::HTML(URI.open(page_url))
  text = if page_url.to_s.match(/dailynews/)
           doc.xpath("//*[@id='detailHeadline']").text
         else
           doc.xpath("//*[@id='contents']//div[@class='newsFeed_item_text']").text
         end
  text.gsub(/\n/, '')
end

def get(page_url)
  urls = get_urls(page_url)
  urls.each do |url|
    text = get_headline_text(url)
    # p text
    request(text)
  end
end

page_url = 'http://news.yahoo.co.jp/list/?c=economy'
get(page_url)
$word_list.each do |key, value|
  p "#{key}=#{value}"
end
