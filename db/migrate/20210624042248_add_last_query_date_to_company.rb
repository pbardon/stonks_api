class AddLastQueryDateToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :last_query_date, :date
  end
end
