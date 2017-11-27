class AddCorrectNumberToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :correct_number, :integer
  end
end
