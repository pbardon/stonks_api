require 'rails_helper'

describe 'company rendering' do
  it 'includes the company information in the search result' do
    company = company_with_prices
    render 'companies/company', company: company
    parsed = JSON.parse(rendered)
    expect(parsed['ticker']).to_not be_nil
    expect(parsed['prices']).to_not be_nil
    expect(parsed['prices'].length).to be(5)
    expect(parsed['prices'][0]['open']).to_not be_nil
  end
end
