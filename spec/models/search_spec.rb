# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'search field validation' do
    it 'is valid with valid attributes' do
      expect(create(:search)).to be_valid
    end

    it 'is not valid without a ticker' do
      search = build(:search)
      # update with invalid attribute returns false
      expect(search.update(ticker: nil)).to be false
      expect(search).to_not be_valid
    end
  end

  describe 'it can query the api for historical price data for a specific company' do
    it 'can query the api and get a result' do
      search = build(:search)
      result = search.query_external_api
      expect(result.class).to eq(Company)
    end
  end

  describe 'it belongs to a single company that we searched for' do
    it 'can create a company associated with the search' do
      c = create(:company)
      c.searches.create(build(:search).attributes)
      expect(c.searches).to_not be_nil
    end

    it 'can be associated with an existing company' do
      c = create(:company)
      s = create(:search)
      s.company = Company.find_by_ticker(c.ticker)
      s.save
      expect(s.company.ticker).to eq(c.ticker)
      expect(c.searches.map(&:id)).to include(s.id)
    end
  end
end
