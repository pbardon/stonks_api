class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :ticker, index: true
      t.date :date, index: true

      t.timestamps
    end
  end
end
