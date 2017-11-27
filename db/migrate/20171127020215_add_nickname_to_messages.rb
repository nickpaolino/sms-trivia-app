class AddNicknameToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :nickname, :string
  end
end
