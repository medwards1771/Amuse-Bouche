class Adapters::LocationScraper
  require 'open-uri'
  attr_reader :url

  def nokogiri_document
    data = open(url).read
    @nokogiri_document ||= Nokogiri::HTML(data)
  end

  def get_locations
    location_section = nokogiri_document.css("div[@data-argument-name='location']")
    locations = location_section[3].elements
    locations.pop
    clean_locations = locations.map{ |element| element.children[2].text }
  end

  private

  def url
    @url ||= "https://www.themuse.com/developers/api/v2"
  end
end