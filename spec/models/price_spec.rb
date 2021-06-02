require 'rails_helper'

RSpec.describe Price, type: :model do
  describe "price field validation" do
    it "is valid with valid attributes" do
      expect(create(:price)).to be_valid
    end

    it "is not valid without a ticker" do
      price = build(:price)
      expect(price.update(ticker: nil)).to be false
      expect(price).to_not be_valid
    end

    it "is not valid without a open" do
      price = build(:price)
      expect(price.update(open: nil)).to be false
      expect(price).to_not be_valid    
    end    
    
    it "is not valid without a close" do
      price = build(:price)
      expect(price.update(close: nil)).to be false
      expect(price).to_not be_valid    
    end    
    
    it "is not valid without a high" do
      price = build(:price)
      expect(price.update(high: nil)).to be false
      expect(price).to_not be_valid    
    end    
    
    it "is not valid without a low" do
      price = build(:price)
      expect(price.update(low: nil)).to be false
      expect(price).to_not be_valid    
    end

    it "is not valid without a volume" do
      price = build(:price)
      expect(price.update(volume: nil)).to be false
      expect(price).to_not be_valid    
    end

    it "is not valid without a timestamp" do
      price = build(:price)
      expect(price.update(timestamp: nil)).to be false
      expect(price).to_not be_valid    
    end
     
    it "is not valid without a querytype" do
      price = build(:price)
      expect(price.update(querytype: nil)).to be false
      expect(price).to_not be_valid    
    end
  end
end
