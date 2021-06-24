# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :price do
    date { rand(10..29).days.ago }
    open { Faker::Number.decimal(l_digits: 2) }
    close { Faker::Number.decimal(l_digits: 2) }
    high { Faker::Number.decimal(l_digits: 2) }
    low { Faker::Number.decimal(l_digits: 2) }
    volume { Faker::Number.number(digits: 5) }
  end

  trait :recent do
    date { rand(10..29).days.ago }
  end

  trait :old do
    date { rand(30..100).days.ago }
  end
end
