class AddStorageLimitToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :storage_allowance, :integer, default: 5000000
  end
end
