class CompanyHasManyPrices < ActiveRecord::Migration[6.1]
  def change
    add_reference :prices, :company, index: true
  end
end
