# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#validates' do
    it 'is valid with valid attributes' do
      expect(create(:company)).to be_valid
    end

    it 'is not valid without a ticker' do
      company = build(:company)
      expect(company.update(ticker: nil)).to be false
      expect(company).to_not be_valid
    end
  end

  describe '#has_many :prices' do
    it 'can create a company with many prices' do
      company = company_with_prices
      expect(company.prices.length).to eq(5)
    end

    it 'can create a new price in the prices collection' do
      company = create(:company)
      expect { company.prices.create(build(:price).attributes) }
        .to change(company.prices, :count).by(1)
    end
  end

  describe '#has_many :searches' do
    it 'can create a company with many searches' do
      company = company_with_searches
      expect(company.searches.length).to eq(4)
    end

    it 'can create a new search in the searches collection' do
      company = create(:company)
      expect { company.searches.create(build(:search).attributes) }
        .to change(company.searches, :count).by(1)
    end
  end

  describe '#last_updated_today?' do
    it 'should check when the company prices were last updated' do
      c = build(:company)
      expect(c.last_updated_today?).to be(false)
      c.last_query_date = 1.day.ago
      expect(c.last_updated_today?).to be(false)
      c.last_query_date = Date.current
      expect(c.last_updated_today?).to be(true)
    end
  end

  describe '#most_recent_price' do
    it 'returns the most recent price' do
      c = company_with_prices
      most_recent = c.most_recent_price
      c.prices.each_with_index do |price, i|
        next if i == 0 || i == c.prices.length - 1

        expect(price.date.before?(most_recent.date)).to be(true)
      end
    end
  end

  describe '#new_price?' do
    it 'validates the presence of a date in the raw data' do
      c = company_with_prices
      expect(c.new_price?({})).to be(false)
    end

    it 'checks if the price for that date already exists' do
      c = company_with_prices
      most_recent = c.most_recent_price
      expect(c.new_price?({ date: most_recent })).to be(false)  
    end
  end
end
