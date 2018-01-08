class User < ApplicationRecord
  has_many :messages

  def most_frequent_messages
    self.messages.map {|msg| msg.content}
  end
end
