require 'spec_helper'

describe LivingSocialApi::DailyDealBuilder do
  let(:fixture_page) do
    Nokogiri::HTML(File.open('spec/fixtures/city_deal_page.html'))
  end

  describe ".build_for_city" do
    before(:each) do
      LivingSocialApi::DailyDealBuilder.stub(:load_page_for).with('denver').and_return(fixture_page)
    end

    it "returns a collection of DailyDeal objects" do
      results = LivingSocialApi::DailyDealBuilder.build_for_city('denver')
      results.should be_kind_of(Enumerable)
      results.each{ |r| r.should be_a(LivingSocialApi::DailyDeal) }
    end
  end

  let(:deal_block) do
    fixture_page.css(".cities-deal").first
  end

  describe ".get_image_url" do
    it "finds the correct URL" do
      url = LivingSocialApi::DailyDealBuilder.get_image_url(deal_block)
      url.should == "http://a3.ak.lscdn.net/imgs/d57e31a8-8865-4fda-840e-1832d8bbd7fe/210_q60_.jpg"
    end
  end

  describe ".get_description" do
    it "finds the correct description" do
      description = LivingSocialApi::DailyDealBuilder.get_description(deal_block)
      description.should == '3-Hour "Intro to Digital Cameras" Class with Demo'
    end
  end

  describe ".get_title" do
    it "finds the correct title" do
      title = LivingSocialApi::DailyDealBuilder.get_title(deal_block)
      title.should == 'Digital Photo Academy'
    end
  end

  describe ".get_original_price" do
    it "finds the correct original price" do
      original_price = LivingSocialApi::DailyDealBuilder.get_original_price(deal_block)
      original_price.should == '$75'
    end
  end

  describe ".get_deal_price" do
    it "finds the correct deal price" do
      deal_price = LivingSocialApi::DailyDealBuilder.get_deal_price(deal_block)
      deal_price.should == '$35'
    end
  end

  describe ".get_url" do
    it "finds the correct deal url" do
      url = LivingSocialApi::DailyDealBuilder.get_url(deal_block)
      url.should == 'http://livingsocial.com/cities/26-denver/deals/375096-3-hour-intro-to-digital-cameras-class-with-demo'
    end
  end

end