class AddResultToSearches < ActiveRecord::Migration[6.1]
  def change
    add_reference :searches, :company, index: true
  end
end
