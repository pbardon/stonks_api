class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :ticker
      t.date :date
      
      t.timestamps
    end
  end
end
