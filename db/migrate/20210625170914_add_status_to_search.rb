class AddStatusToSearch < ActiveRecord::Migration[6.1]
  def change
    add_column :searches, :search_status, :integer, default: 0
  end
end
