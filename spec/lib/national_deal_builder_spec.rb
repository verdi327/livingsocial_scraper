require 'spec_helper'

describe LivingSocialApi::NationalDealBuilder do
  let(:fixture_page) do
    Nokogiri::HTML(File.open('spec/fixtures/national_deal_page.html'))
  end

  describe ".get_deals" do
    before(:each) do
      LivingSocialApi::NationalDealBuilder.stub(:load_page).and_return(fixture_page)
    end

    it "returns a collection of NationalDeal objects" do
      results = LivingSocialApi::NationalDealBuilder.get_deals
      results.should be_kind_of(Enumerable)
      results.each{ |r| r.should be_a(LivingSocialApi::NationalDeal) }
    end
  end

  let(:deal_block) do
    fixture_page.css(".flexdeals.daily").children.select {|item| item.text.strip != "" }.first
  end

  describe ".get_image_url" do
    it "finds the correct URL" do
      url = LivingSocialApi::NationalDealBuilder.get_image_url(deal_block)
      url.should == "http://lscdn.net/imgs/d520175d-cbc1-4063-a2f8-ac9155c44d12"
    end
  end

  describe ".get_description" do
    it "finds the correct description" do
      description = LivingSocialApi::NationalDealBuilder.get_description(deal_block)
      description.should == 'Customized 20-Page Hardcover Photo Book'
    end
  end

  describe ".get_title" do
    it "finds the correct title" do
      title = LivingSocialApi::NationalDealBuilder.get_title(deal_block)
      title.should == 'Picaboo'
    end
  end

  describe ".get_original_price" do
    it "finds the correct original price" do
      original_price = LivingSocialApi::NationalDealBuilder.get_original_price(deal_block)
      original_price.should == '$40'
    end
  end

  describe ".get_deal_price" do
    it "finds the correct deal price" do
      deal_price = LivingSocialApi::NationalDealBuilder.get_deal_price(deal_block)
      deal_price.should == '$10'
    end
  end

  describe ".get_url" do
    it "finds the correct deal url" do
      url = LivingSocialApi::NationalDealBuilder.get_url(deal_block)
      url.should == 'http://livingsocial.com/nationwide/cities/1-washington-d-c/deals/379394-customized-20-page-hardcover-photo-book'
    end
  end

end