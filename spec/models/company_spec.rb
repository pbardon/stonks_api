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
  end

  describe "has many prices" do
    it "can create a company with many prices" do
      company = company_with_prices
      expect(company.prices.length).to eq(5)
    end

    it "can create a new price in the prices collection" do
      company = create(:company)
      expect { company.prices.create(build(:price).attributes) }
        .to change(company.prices, :count).by(1)
    end
  end

  describe "has many searches" do
    it "can create a company with many searches" do
      company = company_with_searches
      expect(company.searches.length).to eq(4)
    end

    it "can create a new search in the searches collection" do
      company = create(:company)
      expect { company.searches.create(build(:search).attributes) }
        .to change(company.searches, :count).by(1)
    end
  end
end
