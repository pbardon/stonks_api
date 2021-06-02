require 'rails_helper'

RSpec.describe Company, type: :model do
  before(:each) do
    @company = create(:company)
  end

  after(:each) do
    @company.destroy
  end

  describe "company field validation" do
    it "is valid with valid attributes" do
      expect(@company).to be_valid
    end

    it "is not valid without a ticker" do
      company = build(:company)
      expect(company.update(ticker: nil)).to be false
      expect(company).to_not be_valid
    end

    it "is not valid without a marketcap" do
      company = build(:company)
      expect(company.update(marketcap: nil)).to be false
      expect(company).to_not be_valid    
    end    
  end

  describe "company has many prices" do
    it "can create a company with a list of prices" do
      @company = company_with_prices
      expect(@company.prices.length).to eq(5)
    end

    it "can create a new price and add it to the prices collection" do
      @company = company_with_prices
      # company = create(:company)
      # expect(company.prices.length).to eq(0)
      # company.prices.create(build(:price).attributes)
      # expect(company.prices.length).to eq(1)
    end
  end
end
