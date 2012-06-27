require 'nokogiri'
require 'open-uri'

module LivingSocialApi
  class DailyDeal
    attr_accessor :image, :title, :description, :original_price, :deal_price, :url

    def initialize(image, title, description, original_price, deal_price, url)
      self.image          = image
      self.title          = title
      self.description    = description
      self.original_price = original_price
      self.deal_price     = deal_price
      self.url            = url
    end
  end
end