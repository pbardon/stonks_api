class Price < ApplicationRecord
    validates :open, presence: true
    validates :close, presence: true
    validates :high, presence: true
    validates :low, presence: true
    validates :volume, presence: true

    belongs_to :company
end
