# frozen_string_literal: true

require 'open-uri'

class Downloader
  def download(url_list_file)
    File.open(url_list_file) do |f|
      f.each do |url|
        url.chomp!

        puts url
        puts URI.open(url)
      end
    end
  end
end

def main(url_list_file)
  if url_list_file.nil? || !File.exist?(url_list_file)
    abort "set first arg as `url list file'"
  end

  downloader = Downloader.new
  downloader.download(url_list_file)
end

main(ARGV[0]) if __FILE__ == $PROGRAM_NAME
