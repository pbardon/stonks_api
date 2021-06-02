class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.float :open
      t.float :close
      t.float :high
      t.float :low
      t.integer :volume
      t.datetime :timestamp
      t.string :querytype
      t.timestamps
    end
  end
end
