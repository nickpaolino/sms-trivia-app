class AddPermissionsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :permissions, :boolean
  end
end
