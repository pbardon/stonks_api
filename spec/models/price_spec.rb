# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#validates' do
    it 'is valid with valid attributes' do
      c = company_with_prices
      expect(c.prices.first).to be_valid
    end

    it 'is not valid without a open' do
      price = build(:price)
      expect(price.update(open: nil)).to be false
      expect(price).to_not be_valid
    end

    it 'is not valid without a close' do
      price = build(:price)
      expect(price.update(close: nil)).to be false
      expect(price).to_not be_valid
    end

    it 'is not valid without a high' do
      price = build(:price)
      expect(price.update(high: nil)).to be false
      expect(price).to_not be_valid
    end

    it 'is not valid without a low' do
      price = build(:price)
      expect(price.update(low: nil)).to be false
      expect(price).to_not be_valid
    end

    it 'is not valid without a volume' do
      price = build(:price)
      expect(price.update(volume: nil)).to be false
      expect(price).to_not be_valid
    end
  end

  describe '#recent' do
    it 'can return only the prices in the last 30 days' do
      c = company_with_prices(10)
      10.times do
        p = build(:price, :old)
        c.prices.append(p)
      end

      expect(c.prices.count).to eq(20)
      expect(c.prices.recent.count).to eq(10)
    end
  end

  describe '#between_dates' do
    it 'can filter prices between two dates' do
      c = company_with_prices(10)
      10.times do
        p = build(:price, :old)
        c.prices.append(p)
      end

      expect(c.prices.between_dates(30.days.ago, Date.today).count).to eq(10)
      expect(c.prices.between_dates(101.days.ago, Date.today).count).to eq(20)
      expect(c.prices.between_dates(105.days.ago, 100.day.ago).count).to eq(0)
    end
  end
end
