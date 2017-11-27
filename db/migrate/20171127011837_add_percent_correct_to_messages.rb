class AddPercentCorrectToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :percent_correct, :string
  end
end
