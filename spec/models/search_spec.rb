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

    it "is not valid without a timestamp" do
        search = build(:search)
        expect(search.update(timestamp: nil)).to be false
        expect(search).to_not be_valid

    end

    it "is not valid without a querytype" do
        search = build(:search)
        expect(search.update(querytype: nil)).to be false
        expect(search).to_not be_valid
    end

    it "is limited to the two possible querytype options" do
        search = build(:search)
        expect(search.update(querytype: "24h")).to be true
        expect(search).to be_valid
        expect(search.update(querytype: "60m")).to be true
        expect(search).to be_valid
        expect(search.update(querytype: "5m")).to be false
        expect(search).to_not be_valid
    end

    it "validates the date in the timestamp" do
        search = build(:search)
        expect(search.update(timestamp: "1234")).to be false
        expect(search).to_not be_valid
        expect(search.update(timestamp: DateTime.now)).to be true
        expect(search).to be_valid
    end
  end
end
