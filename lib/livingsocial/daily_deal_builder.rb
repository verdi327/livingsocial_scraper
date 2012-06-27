module LivingSocialApi
  module DailyDealBuilder
    BASE_URL = "http://livingsocial.com"

    def self.load_page_for(city)
      Nokogiri::HTML(open("#{BASE_URL}/cities/#{city}"))
    end

    def self.page_for(city)
      yield(load_page_for(city))
    end

    def self.build_for_city(city)
      page_for(city) do |doc|
        doc.css(".cities-deal").collect do |deal|
          new_from_html(deal)
        end
      end
    end

    def self.get_image_url(html)
      html.css('.deal-image img').attribute('src').value.strip
    end

    def self.get_title(html)
      html.css('.deal-title h3 a').text.strip
    end

    def self.get_description(html)
      html.css('.deal-title p').text.strip
    end

    def self.get_original_price(html)
      html.css('.deal-strike').text.strip
    end

    def self.get_deal_price(html)
      html.css('.deal-price').text.strip
    end

    def self.get_url(html)
      BASE_URL + html.css('.deal-image a').attribute('href').value.strip
    end

    def self.new_from_html(html)
      image          = get_image_url(html)
      title          = get_title(html)
      description    = get_description(html)
      original_price = get_original_price(html)
      deal_price     = get_deal_price(html)
      url            = get_url(html)
      DailyDeal.new(image, title, description, original_price, deal_price, url)
    end
  end
end