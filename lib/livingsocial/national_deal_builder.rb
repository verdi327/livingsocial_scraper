require 'nokogiri'
require 'open-uri'

module LivingSocialApi
  module NationalDealBuilder
    URL = 'http://livingsocial.com/nationwide'

    def self.load_page
      Nokogiri::HTML(open(URL))
    end

    def self.page
      yield(load_page)
    end

    def self.get_deals
      page do |doc|
        doc.css(".flexdeals.daily").children.select {|item| item.text.strip != "" }.collect do |deal|
          new_from_html(deal)
        end
      end
    end

    def self.get_image_url(html)
      html.children.css('a img').attribute('src').value
    end

    def self.get_title(html)
      html.children.css('h3 a').text.strip
    end

    def self.get_description(html)
      html.children.css('h4 a').text.strip
    end

    def self.get_original_price(html)
      html.children.css('p del').text.strip
    end

    def self.get_deal_price(html)
      html.children.css('p span').text.strip
    end

    def self.get_url(html)
      URL + html.children.css('h3 a').first.attributes['href'].value.strip
    end

    def self.new_from_html(html)
      image          = get_image_url(html)
      title          = get_title(html)
      description    = get_description(html)
      original_price = get_original_price(html)
      deal_price     = get_deal_price(html)
      url            = get_url(html)
      NationalDeal.new(image, title, description, original_price, deal_price, url)
    end
  end
end
