class CompanyHasManyPrices < ActiveRecord::Migration[6.1]
  def change
    add_column :prices, :company_ticker, :string
    add_index :prices, :company_ticker
  end
end
