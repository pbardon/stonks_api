class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies, id: false, primary_key: :ticker do |t|
      t.string :ticker, null: false, primary_key: true
      t.float :marketcap

      t.timestamps
    end
  end
end
