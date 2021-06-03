require 'rails_helper'

describe 'search rendering' do
    it 'includes the search information in the search result' do
        search = create(:search)
        company = create(:company)
        search.company = company
        render 'searches/search', search: search

        parsed = JSON.parse(rendered)
        expect(parsed['ticker']).to_not be_nil
        expect(parsed['date']).to_not be_nil
    end
end