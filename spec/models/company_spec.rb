require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "company field validation" do
    it "is valid with valid attributes" do
      expect(create(:company)).to be_valid
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
end
