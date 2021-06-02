require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "search field validation" do
    it "is valid with valid attributes" do
        expect(create(:search)).to be_valid
    end

    it "is not valid without a ticker" do
        search = build(:search)
        # update with invalid attribute returns false
        expect(search.update(ticker: nil)).to be false
        expect(search).to_not be_valid
    end
  end
end
